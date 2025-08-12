# db/seeds.rb

Symptom.find_or_create_by!(title: "やけど") do |s|
  s.summary = "冷却が基本。程度によって対応が変わる。"
  s.home_care = "流水で20分冷却。衣類が貼り付いていたら剥がさない。"
  s.checkpoints = "範囲、水疱の有無、部位、痛みの強さ、年齢。"
  s.visit_immediate = "顔・関節・陰部、大きな水疱、広範囲（手のひら数枚分）。"
  s.visit_hours = "赤みのみで痛み軽度など。"
end

Symptom.find_or_create_by!(title: "発熱") do |s|
  s.summary = "体温が平熱より高い状態。感染症や炎症などが原因になることが多い。"
  s.home_care = "安静、水分補給。食欲があれば無理に食事制限は不要。"
  s.checkpoints = "熱の高さ、持続時間、他の症状（発疹、咳、けいれんなど）の有無。"
  s.visit_immediate = "生後3か月未満の発熱、39℃以上が続く、けいれん、意識がぼんやり。"
  s.visit_hours = "38℃以上が2日以上続く、元気がない、食欲低下。"
end

Symptom.find_or_create_by!(title: "嘔吐・下痢") do |s|
  s.summary = "消化器系の感染や食中毒などで起こる。脱水に注意。"
  s.home_care = "少量ずつこまめに水分補給。脂っこい食事や乳製品は控える。"
  s.checkpoints = "回数、吐いた物や便の色・性状、発熱の有無、尿の回数。"
  s.visit_immediate = "血便、黒色便、強い腹痛、意識がぼんやり、尿が半日以上出ていない。"
  s.visit_hours = "嘔吐・下痢が続く、発熱、元気がない。"
end

Symptom.find_or_create_by!(title: "咳・呼吸が苦しい") do |s|
  s.summary = "風邪や気管支炎、肺炎、ぜんそくなどで起こる。重症化に注意。"
  s.home_care = "安静、加湿、水分補給。咳止めは医師の指示がある場合のみ使用。"
  s.checkpoints = "呼吸数、ゼーゼー音、胸の動き、顔色、唇の色。"
  s.visit_immediate = "呼吸困難、唇や顔が紫色、ぐったりしている。"
  s.visit_hours = "咳が長引く、夜間に悪化、発熱が続く。"
end

Symptom.find_or_create_by!(title: "けいれん") do |s|
  s.summary = "意識の低下や体の硬直・けいれん運動が見られる状態。発熱時に起こる熱性けいれんが多い。"
  s.home_care = "安全な場所に寝かせ、呼吸や顔色を観察。無理に抑えない。"
  s.checkpoints = "発作の時間、左右対称か、発熱の有無、発作後の意識の回復。"
  s.visit_immediate = "5分以上続く、繰り返す、呼吸困難、意識が戻らない。"
  s.visit_hours = "初めての発作、短時間でも心配な場合。"
end

Symptom.find_or_create_by!(title: "誤飲、誤嚥") do |s|
  s.summary = "異物を飲み込む、または気道に入る状態。窒息や中毒に注意。"
  s.home_care = "呼吸可能なら落ち着かせる。危険物（電池、薬など）は早急に受診。"
  s.checkpoints = "何をどれだけ飲んだか、咳・嘔吐・呼吸状態。"
  s.visit_immediate = "呼吸困難、唇が紫色、意識低下。"
  s.visit_hours = "ボタン電池、磁石、薬、鋭利な物を飲んだ疑い。"
end

Symptom.find_or_create_by!(title: "鼻出血") do |s|
  s.summary = "鼻粘膜からの出血。多くは乾燥や外傷が原因。"
  s.home_care = "小鼻をつまみ、前かがみで5〜10分圧迫。"
  s.checkpoints = "出血量、持続時間、繰り返しの有無、打撲や外傷の有無。"
  s.visit_immediate = "大量出血、止血困難、頭部外傷後。"
  s.visit_hours = "繰り返す、止まりにくい、他の出血傾向あり。"
end

Symptom.find_or_create_by!(title: "元気がない、不機嫌") do |s|
  s.summary = "普段と比べて活動性が低下、笑顔がない、泣きやすい状態。"
  s.home_care = "休養、水分補給。発熱や他症状の有無を確認。"
  s.checkpoints = "持続時間、発熱、食欲、睡眠の様子。"
  s.visit_immediate = "ぐったりして反応が乏しい、呼吸困難、意識障害。"
  s.visit_hours = "半日以上続く、他症状を伴う。"
end

Symptom.find_or_create_by!(title: "じんま疹、湿疹") do |s|
  s.summary = "皮膚に赤い盛り上がりやかゆみ、発疹が出る状態。"
  s.home_care = "冷やす、かゆみが強ければ掻かないよう注意。"
  s.checkpoints = "広がり方、かゆみの程度、呼吸症状の有無。"
  s.visit_immediate = "呼吸困難、顔や喉の腫れ、全身に急速に広がる。"
  s.visit_hours = "発疹が長引く、かゆみが強い。"
end

Symptom.find_or_create_by!(title: "便秘") do |s|
  s.summary = "排便回数が少ない、または排便が困難な状態。"
  s.home_care = "水分・食物繊維を増やす、規則正しい生活。"
  s.checkpoints = "最終排便日、便の硬さ・量、腹痛の有無。"
  s.visit_immediate = "激しい腹痛、嘔吐、血便。"
  s.visit_hours = "便秘が1週間以上続く、腹部膨満。"
end

Symptom.find_or_create_by!(title: "けが") do |s|
  s.summary = "転倒や打撲、切り傷などによる外傷。"
  s.home_care = "出血部を圧迫止血、流水で洗浄。"
  s.checkpoints = "出血量、傷の深さ、汚れ、痛みの程度。"
  s.visit_immediate = "出血が止まらない、深い傷、頭部外傷。"
  s.visit_hours = "傷が化膿している、腫れや痛みが増している。"
end

Symptom.find_or_create_by!(title: "虫刺され") do |s|
  s.summary = "蚊やダニ、ハチなどに刺された状態。"
  s.home_care = "冷やす、かゆみが強ければ市販薬。"
  s.checkpoints = "腫れや発赤の範囲、呼吸症状の有無。"
  s.visit_immediate = "呼吸困難、全身症状、広範囲の腫れ。"
  s.visit_hours = "腫れやかゆみが強く長引く。"
end

Symptom.find_or_create_by!(title: "アレルギー疾患") do |s|
  s.summary = "花粉症、アトピー性皮膚炎、食物アレルギーなどの慢性的な症状。"
  s.home_care = "原因回避、処方薬の継続使用。"
  s.checkpoints = "症状の変化、呼吸症状の有無。"
  s.visit_immediate = "呼吸困難、全身に急速に広がる発疹。"
  s.visit_hours = "症状悪化、薬で改善しない。"
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?