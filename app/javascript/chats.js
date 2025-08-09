document.addEventListener('DOMContentLoaded', () => {
  
  // ============ メイン関数 ============
  
  function handleFormSubmit(e) {
    e.preventDefault();
    
    // 毎回最新のDOM要素を取得
    const form = document.getElementById('generation-form');
    const messagesList = document.getElementById('messages-list');
    
    if (!form || !messagesList) {
      console.error('フォームまたはメッセージリストが見つかりません');
      return;
    }
    
    const formData = new FormData(form);
    const token = document.querySelector('meta[name="csrf-token"]').content;
    const promptContent = form.querySelector('textarea').value;
    
    // 入力チェック
    if (!isValidInput(promptContent)) {
      return;
    }
    
    const targetElement = appendMessageElement(promptContent, messagesList);
    form.reset();
    resetTextareaSize(form.querySelector('textarea'));
    
    sendPrompt(form.action, formData, token, targetElement);
  }
  
  function appendMessageElement(promptContent, messagesList) {
    const messageElement = document.createElement('div');
    messageElement.innerHTML = `
      <div class="prompt-box">
        <p class="prompt">You:</p>
        <p class="prompt-text">${formatText(promptContent)}</p>
      </div>
      <div class="response-box">
        <p class="response">GPT:</p>
        <p class="response-text"></p>
      </div>
    `;
    messagesList.appendChild(messageElement);
    scrollToBottom();
    return messageElement.querySelector('.response-text');
  }
  
  function sendPrompt(actionUrl, formData, token, targetElement) {
    fetch(actionUrl, {
      method: 'POST',
      body: formData,
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': token
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      if (data.error) {
        throw new Error(data.error);
      }
      displayResponse(data.response, targetElement);
      if (data.thread_title) {
        updateThreadTitleDisplay(data.thread_title);
      }
    })
    .catch(error => {
      console.error('詳細なエラー:', error);
      handleAPIError(error, targetElement);
    });
  }
  
  function createNewThread() {
    fetch('/chat_threads', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.chat_thread) {
        history.pushState(null, '', `/chat_threads/${data.chat_thread.id}`);
        updateChatInterface(data.chat_thread, []);
      } else {
        console.error('新規スレッドの作成に失敗しました', data.errors);
      }
    })
    .catch(error => console.error('新規スレッドの作成に失敗しました', error));
  }
  
  function fetchChatThreads() {
    fetch('/chat_threads', {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
    .then(response => response.json())
    .then(data => {
      const threadsList = document.getElementById('threads-list');
      if (!threadsList) return;
      
      threadsList.innerHTML = '';
      data.chat_threads.forEach(chatThread => {
        const threadItem = document.createElement('div');
        threadItem.classList.add('thread-item');
        threadItem.dataset.chatThreadId = chatThread.id;
        threadItem.textContent = chatThread.title;
        threadsList.appendChild(threadItem);
      });
    })
    .catch(error => console.error('スレッド一覧の取得に失敗しました', error));
  }
  
  function handleThreadSelection(e) {
    if (e.target.classList.contains('thread-item')) {
      const chatThreadId = e.target.dataset.chatThreadId;
      fetchAndDisplayThread(chatThreadId);
    }
  }
  
  function fetchAndDisplayThread(chatThreadId) {
    fetch(`/chat_threads/${chatThreadId}`, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
    .then(response => response.json())
    .then(data => {
      history.pushState(null, '', `/chat_threads/${chatThreadId}`);
      hideThreadsModal();
      updateChatInterface(data.chat_thread, data.messages);
    })
    .catch(error => {
      alert('スレッドの読み込みに失敗しました。もう一度お試しください。');
      console.error(error);
    });
  }
  
  // ============ UI更新関数 ============
  
  function updateChatInterface(chatThread, messages) {
    const centerContainer = document.querySelector('.center-container');
    if (centerContainer) {
      centerContainer.remove();
    }
    
    // DOM全体を再構築
    document.body.innerHTML = '';
    
    const newHtml = `
      <pre style="display: none;">${chatThread.context || ''}</pre>
      <h1 id="thread-title">${chatThread.title || 'Untitled Thread'}</h1>
      <div id="thread-controls">
        <button id="new-thread-btn" class="thread-control-btn">+</button>
        <button id="show-threads-btn" class="thread-control-btn">❏</button>
      </div>
      <div id="chat-container">
        <div id="messages-list"></div>
      </div>
      <form id="generation-form" action="/chat_threads/${chatThread.id}/messages" method="post" accept-charset="UTF-8">
        <div class="textarea-with-submit-inside">
          <textarea name="message[prompt]" class="rounded-corners" id="message_prompt"></textarea>
          <input type="submit" value="↑" class="submit-within-textarea rounded-corners" data-disable-with="↑">
        </div>
      </form>
      <div id="threads-modal">
        <div id="threads-modal-content">
          <button id="close-threads-btn">&times;</button>
          <h2 class="modal-title">スレッド一覧</h2>
          <div id="threads-list"></div>
        </div>
      </div>
    `;
    
    document.body.insertAdjacentHTML('afterbegin', newHtml);
    
    // メッセージを追加
    if (messages && Array.isArray(messages)) {
      const messagesList = document.getElementById('messages-list');
      messages.forEach(message => {
        if (message.prompt && messagesList) {
          appendPrompt(message.prompt, message.response);
        }
      });
    }
    
    // イベントリスナーを再設定
    InitializeInterface();
  }
  
  function InitializeInterface() {
    // フォームのイベントリスナー
    const form = document.getElementById('generation-form');
    if (form) {
      form.addEventListener('submit', handleFormSubmit);
      
      const textarea = form.querySelector('textarea');
      if (textarea) {
        textarea.addEventListener('input', () => adjustTextareaHeight(textarea));
        textarea.addEventListener('keydown', handleTextareaKeydown);
      }
    }
    
    // 各ボタンのイベントリスナー
    const showThreadsBtn = document.getElementById('show-threads-btn');
    if (showThreadsBtn) {
      showThreadsBtn.addEventListener('click', () => {
        fetchChatThreads();
        const modal = document.getElementById('threads-modal');
        if (modal) modal.style.display = 'flex';
      });
    }
    
    const closeThreadsBtn = document.getElementById('close-threads-btn');
    if (closeThreadsBtn) {
      closeThreadsBtn.addEventListener('click', () => {
        const modal = document.getElementById('threads-modal');
        if (modal) modal.style.display = 'none';
      });
    }
    
    const threadsList = document.getElementById('threads-list');
    if (threadsList) {
      threadsList.addEventListener('click', handleThreadSelection);
    }
    
    const newThreadBtn = document.getElementById('new-thread-btn');
    if (newThreadBtn) {
      newThreadBtn.addEventListener('click', createNewThread);
    }
    
    renderMarkdown();
    scrollToBottom();
  }
  
  // ============ ヘルパー関数 ============
  
  function isValidInput(input) {
    return /\S/.test(input);
  }
  
  function handleTextareaKeydown(e) {
    if (e.key === 'Enter' && !e.shiftKey && !e.isComposing) {
      e.preventDefault();
      if (isValidInput(e.target.value)) {
        const form = document.getElementById('generation-form');
        if (form) {
          form.dispatchEvent(new Event('submit'));
        }
      }
    }
  }
  
  function updateThreadTitleDisplay(title) {
    const titleElement = document.getElementById('thread-title');
    if (titleElement) {
      titleElement.textContent = title;
    } else {
      const newTitleElement = document.createElement('h1');
      newTitleElement.id = 'thread-title';
      newTitleElement.textContent = title;
      document.body.insertBefore(newTitleElement, document.body.firstChild);
    }
  }
  
  function displayResponse(text, container) {
    // markedが読み込まれているか確認
    if (typeof marked === 'undefined') {
      console.error('marked.js が読み込まれていません');
      container.textContent = text;
      return;
    }
    
    container.setAttribute('data-markdown', text);
    const htmlContent = marked.parse(text);
    
    let currentIndex = 0;
    const intervalId = setInterval(() => {
      if (currentIndex < htmlContent.length) {
        container.innerHTML = htmlContent.substring(0, currentIndex + 1);
        currentIndex++;
        scrollToBottom();
      } else {
        clearInterval(intervalId);
        // hljsも確認
        if (typeof hljs !== 'undefined') {
          container.querySelectorAll('pre code').forEach((block) => {
            hljs.highlightBlock(block);
          });
        }
        scrollToBottom();
      }
    }, 5);
  }
  
  function scrollToBottom() {
    const chatContainer = document.getElementById('chat-container');
    if (chatContainer) {
      chatContainer.scrollTop = chatContainer.scrollHeight;
    }
  }
  
  function handleAPIError(error, container) {
    console.error('APIリクエストが失敗しました', error);
    container.innerText = 'エラーが発生しました。';
  }
  
  function formatText(text) {
    const escapeHtml = (unsafe) => {
      return unsafe
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
    };
    return escapeHtml(text).replace(/\n/g, '<br>');
  }
  
  function appendPrompt(content, response) {
    const messagesList = document.getElementById('messages-list');
    if (!messagesList) return;
    
    const promptElement = document.createElement('div');
    promptElement.innerHTML = `
      <div class="prompt-box">
        <p class="prompt">You:</p>
        <p class="prompt-text">${formatText(content)}</p>
      </div>
      <div class="response-box">
        <p class="response">GPT:</p>
        <p class="response-text" data-markdown>${response}</p>
      </div>
    `;
    messagesList.appendChild(promptElement);
  }
  
  function adjustTextareaHeight(textarea) {
    textarea.style.height = 'auto';
    textarea.style.height = `${textarea.scrollHeight}px`;
  }
  
  function resetTextareaSize(textarea) {
    if (textarea) {
      textarea.style.height = 'auto';
    }
  }
  
  function renderMarkdown() {
    if (typeof marked === 'undefined') {
      console.warn('marked.js が読み込まれていません');
      return;
    }
    
    document.querySelectorAll('.response-text[data-markdown]').forEach(elem => {
      const markdownText = elem.getAttribute('data-markdown') || elem.textContent;
      elem.innerHTML = marked.parse(markdownText);
      
      // コードハイライト
      if (typeof hljs !== 'undefined') {
        elem.querySelectorAll('pre code').forEach((block) => {
          hljs.highlightBlock(block);
        });
      }
    });
  }
  
  function hideThreadsModal() {
    const modal = document.getElementById('threads-modal');
    if (modal) {
      modal.style.display = 'none';
    }
  }
  
  // ============ 初期化 ============
  
  InitializeInterface();
  
  // モーダル外クリックで閉じる
  window.addEventListener('click', (event) => {
    const modal = document.getElementById('threads-modal');
    if (event.target === modal) {
      modal.style.display = 'none';
    }
  });
});