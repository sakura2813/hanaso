# db/seeds.rb
# ─────────────────────────────────────────────
# 本番対応：何度実行しても重複しない upsert（上書き or 追加）
def upsert_symptom!(attrs)
  rec = Symptom.find_or_initialize_by(title: attrs[:title])
  rec.assign_attributes(attrs) # 画像は扱わない（管理画面で後付け）
  rec.save!
end

SYMPTOMS = [
  { title: "やけど",
    summary: "冷却が基本。程度によって対応が変わる。",
    home_care: "流水で20分冷却。衣類が貼り付いていたら剥がさない。",
    checkpoints: "範囲、水疱の有無、部位、痛みの強さ、年齢。",
    visit_immediate: "顔・関節・陰部、大きな水疱、広範囲（手のひら数枚分）。",
    visit_hours: "赤みのみで痛み軽度など。" },

  { title: "発熱",
    summary: "体温が平熱より高い状態。感染症や炎症などが原因になることが多い。",
    home_care: "安静、水分補給。食欲があれば無理に食事制限は不要。",
    checkpoints: "熱の高さ、持続時間、他の症状（発疹、咳、けいれんなど）の有無。",
    visit_immediate: "生後3か月未満の発熱、39℃以上が続く、けいれん、意識がぼんやり。",
    visit_hours: "38℃以上が2日以上続く、元気がない、食欲低下。" },

  { title: "嘔吐・下痢",
    summary: "消化器系の感染や食中毒などで起こる。脱水に注意。",
    home_care: "少量ずつこまめに水分補給。脂っこい食事や乳製品は控える。",
    checkpoints: "回数、吐いた物や便の色・性状、発熱の有無、尿の回数。",
    visit_immediate: "血便、黒色便、強い腹痛、意識がぼんやり、尿が半日以上出ていない。",
    visit_hours: "嘔吐・下痢が続く、発熱、元気がない。" },

  { title: "咳・呼吸が苦しい",
    summary: "風邪や気管支炎、肺炎、ぜんそくなどで起こる。重症化に注意。",
    home_care: "安静、加湿、水分補給。咳止めは医師の指示がある場合のみ使用。",
    checkpoints: "呼吸数、ゼーゼー音、胸の動き、顔色、唇の色。",
    visit_immediate: "呼吸困難、唇や顔が紫色、ぐったりしている。",
    visit_hours: "咳が長引く、夜間に悪化、発熱が続く。" },

  { title: "けいれん",
    summary: "意識の低下や体の硬直・けいれん運動。発熱時の熱性けいれんが多い。",
    home_care: "安全な場所に寝かせ、呼吸や顔色を観察。無理に抑えない。",
    checkpoints: "発作時間、左右対称か、発熱の有無、発作後の意識の回復。",
    visit_immediate: "5分以上続く、繰り返す、呼吸困難、意識が戻らない。",
    visit_hours: "初めての発作、短時間でも心配な場合。" },

  { title: "誤飲、誤嚥",
    summary: "異物を飲み込む、または気道に入る状態。窒息や中毒に注意。",
    home_care: "呼吸可能なら落ち着かせる。危険物（電池、薬など）は早急に受診。",
    checkpoints: "何をどれだけ飲んだか、咳・嘔吐・呼吸状態。",
    visit_immediate: "呼吸困難、唇が紫色、意識低下。",
    visit_hours: "ボタン電池、磁石、薬、鋭利な物を飲んだ疑い。" },

  { title: "鼻出血",
    summary: "鼻粘膜からの出血。多くは乾燥や外傷が原因。",
    home_care: "小鼻をつまみ、前かがみで5〜10分圧迫。",
    checkpoints: "出血量、持続時間、繰り返しの有無、打撲や外傷の有無。",
    visit_immediate: "大量出血、止血困難、頭部外傷後。",
    visit_hours: "繰り返す、止まりにくい、他の出血傾向あり。" },

  { title: "元気がない、不機嫌",
    summary: "活動性低下・笑顔がない・泣きやすいなど。",
    home_care: "休養、水分補給。発熱や他症状の有無を確認。",
    checkpoints: "持続時間、発熱、食欲、睡眠の様子。",
    visit_immediate: "ぐったりして反応が乏しい、呼吸困難、意識障害。",
    visit_hours: "半日以上続く、他症状を伴う。" },

  { title: "じんま疹、湿疹",
    summary: "皮膚に赤い盛り上がりやかゆみ、発疹。",
    home_care: "冷やす、掻かないよう注意。",
    checkpoints: "広がり、かゆみの程度、呼吸症状の有無。",
    visit_immediate: "呼吸困難、顔や喉の腫れ、全身に急速に広がる。",
    visit_hours: "発疹が長引く、かゆみが強い。" },

  { title: "便秘",
    summary: "排便回数が少ない、または排便が困難な状態。",
    home_care: "水分・食物繊維を増やす、規則正しい生活。",
    checkpoints: "最終排便日、便の硬さ・量、腹痛の有無。",
    visit_immediate: "激しい腹痛、嘔吐、血便。",
    visit_hours: "便秘が1週間以上続く、腹部膨満。" },

  { title: "けが",
    summary: "転倒や打撲、切り傷などによる外傷。",
    home_care: "出血部を圧迫止血、流水で洗浄。",
    checkpoints: "出血量、傷の深さ、汚れ、痛みの程度。",
    visit_immediate: "出血が止まらない、深い傷、頭部外傷。",
    visit_hours: "傷が化膿、腫れや痛みが増している。" },

  { title: "虫刺され",
    summary: "蚊やダニ、ハチなどに刺された状態。",
    home_care: "冷やす、かゆみが強ければ市販薬。",
    checkpoints: "腫れや発赤の範囲、呼吸症状の有無。",
    visit_immediate: "呼吸困難、全身症状、広範囲の腫れ。",
    visit_hours: "腫れやかゆみが強く長引く。" },

  { title: "アレルギー疾患",
    summary: "花粉症、アトピー性皮膚炎、食物アレルギーなど。",
    home_care: "原因回避、処方薬の継続使用。",
    checkpoints: "症状の変化、呼吸症状の有無。",
    visit_immediate: "呼吸困難、全身に急速に広がる発疹。",
    visit_hours: "症状悪化、薬で改善しない。" }
]

Symptom.transaction { SYMPTOMS.each { |attrs| upsert_symptom!(attrs) } }

if Rails.env.production? && defined?(AdminUser)
  AdminUser.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |u|
    u.password = ENV["ADMIN_PASSWORD"]
    u.password_confirmation = ENV["ADMIN_PASSWORD"]
  end
end
