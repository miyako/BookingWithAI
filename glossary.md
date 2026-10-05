# 用語集 / Glossary

Keep terminology consistent across `src/<target>.md` and `figures/*.<target>.txt`.
Change an entry here first, then search and replace in both places.

Style (ja): です・ます調. Half-width alphanumerics, no space between Japanese and Latin text (e.g. `4D.Vector型`).
Full-width `（）` and `：` in prose. First occurrence of a technical term: 日本語（English）.

## 4D terms (from the official 4D Japanese documentation)

| English | 日本語 | Notes |
|---|---|---|
| entity / entity selection | エンティティ / エンティティセレクション | |
| datastore | データストア | |
| dataclass | データクラス | |
| attribute | 属性 | |
| computed attribute | 計算属性 | |
| collection | コレクション | |
| object | オブジェクト | |
| method | メソッド | |
| project method | プロジェクトメソッド | |
| function | 関数 | |
| class | クラス | |
| parameter | 引数 | |
| form | フォーム | |
| form object | フォームオブジェクト | |
| list box | リストボックス | |
| web area | Webエリア | |
| 4D Web Server | 4D Webサーバー | |
| worker | ワーカー | |
| process | プロセス | |
| query | クエリ | |
| formula | フォーミュラ | |
| component | コンポーネント | |
| table / field / record | テーブル / フィールド / レコード | |
| list box (prose: listbox) | リストボックス | |
| command (e.g. Day of) | コマンド | Command names stay in English |
| Component Manager | コンポーネントマネージャー | To confirm against the current 4D docs (dependency manager) |

## Document-specific terms

| English | 日本語 | Notes |
|---|---|---|
| tool calling | ツール呼び出し | First occurrence: ツール呼び出し（tool calling） |
| function calling | 関数呼び出し | |
| tool / tool definition | ツール / ツール定義 | |
| dispatcher / dispatch | ディスパッチャー / ディスパッチ（振り分け） | |
| business logic / business method | ビジネスロジック / ビジネスメソッド | |
| conversation loop | 会話ループ | |
| system prompt / system message | システムプロンプト / システムメッセージ | |
| scope guard / guardrail | スコープガード / ガードレール | |
| round (of tool calls) / round trip | ラウンド / 往復 | |
| turn (visitor turn) | ターン（訪問者の1ターン） | |
| visitor | 訪問者 | |
| client (patient) | 患者 | Editor: clinic context. Table name Client stays as is |
| staff (member) | スタッフ | |
| appointment / booking | 予約 | |
| reschedule | 予約の変更 | |
| free slot / slot | 空き枠 / 枠 | |
| availability | 空き状況 | Table name Availability stays as is |
| confirmation code | 確認コード | |
| seed / seeded | 初期投入 / 初期投入された | |
| web chat | Webチャット | |
| Web Chat UI | WebチャットUI | fig-02 |
| Admin form | 管理フォーム | Window title 予約管理 (Appointment Manager) |
| Status confirmed / cancelled | 確定済み / キャンセル済み | Admin form display label (statusLabel); stored values stay English |
| Reason (appointment) | 用件 | Admin detail label |
| Tool Activity panel | ツールアクティビティパネル | UI label 「🔧 ツールアクティビティ」; must match the localised demo (Phase 5) |
| filter buttons Upcoming / Past / All / Cancelled | ［今後］／［過去］／［すべて］／［キャンセル済み］ | Must match the localised Admin form |
| Cancel appointment (button) | ［予約をキャンセル］ | Admin form button label (XLIFF Admin_BtnCancel) |
| AI Provider | AIプロバイダー | |
| Tech Note / Tech Tip | テクニカルノート / Tech Tip | |
| Beat (demo section) | シーン | |
| Type / say | 入力する内容 | |
| Fires | 実行されるツール | |
| Narration cue | 説明のポイント | |
| Why it lands | ここが見どころ | |
| Note | 注 | |
| front door | 入り口 | |
| pill button | ピル型のボタン | |

## Proper nouns in examples

| English | 日本語 | Notes |
|---|---|---|
| Kestrel Health | はやぶさクリニック | Decided by the editor; demo and document |
| GPT-4o (LLM) in fig-01 | GPT-5 (LLM) | Editor: consistent with model: "gpt-5" in the code |
| Dr. Jean Martin (Cardiology) | 田中 健一（田中先生） | Staff; k.tanaka@hayabusa-clinic.example, +81 3 1234 5678 |
| Dr. Claire Bernard (General Medicine) | 佐藤 美咲（佐藤先生） | Staff; m.sato@hayabusa-clinic.example, +81 3 1234 5679 |
| Paul Dupuis (Support) | 鈴木 大輔 | Staff; d.suzuki@hayabusa-clinic.example, +81 3 1234 5680 |
| Marie Dupont | 高橋 結衣 | Patient; yui.takahashi@example.com, +81 90 1234 5678 |
| Thomas Leroy | 伊藤 翔太 | Patient; shota.ito@example.com, +81 90 9876 5432 |
| Nathalie Rousseau | 渡辺 真由美 | Patient; mayumi.watanabe@example.com, +81 80 1122 3344 |
| Antoine Moreau | 中村 拓也 | Patient; takuya.nakamura@example.com, +81 70 5566 7788 |
| Sophie Laurent (new patient, scene 2) | 小林 さくら | sakura.kobayashi@example.com |
| Name order | 姓 名 (family name first) | fullName = lastName + " " + firstName in the demo |
| Appointment reasons | 定期健診, 年次健康診断, 機器のサポート, 経過観察, インフルエンザの症状, 循環器内科の診察, サポートの依頼, 患者による予約変更 | APT_Seed |
| Cardiology / General Medicine / Support | 循環器内科 / 一般内科 / 受付サポート | Specialties in the seeded data |
