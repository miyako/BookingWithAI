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
| client (customer) | 顧客 | Table name Client stays as is |
| staff (member) | スタッフ | |
| appointment / booking | 予約 | |
| reschedule | 予約の変更 | |
| free slot / slot | 空き枠 / 枠 | |
| availability | 空き状況 | Table name Availability stays as is |
| confirmation code | 確認コード | |
| seed / seeded | 初期投入 / 初期投入された | |
| web chat | Webチャット | |
| Web Chat UI | WebチャットUI | fig-02 |
| Admin form | 管理フォーム | |
| Tool Activity panel | ツールアクティビティパネル | UI label 「🔧 ツールアクティビティ」; must match the localised demo (Phase 5) |
| filter buttons Upcoming / Past / All / Cancelled | ［今後］／［過去］／［すべて］／［キャンセル済み］ | Must match the localised Admin form |
| Cancel (button) | ［キャンセル］ | |
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
| Dr. Jean Martin, Dr. Claire Bernard, Paul Dupuis | (Phase 4) | Placeholder: Latin in data/code, katakana (マルタン先生…) in quoted speech |
| Marie Dupont, Thomas Leroy, Nathalie Rousseau, Antoine Moreau, Sophie Laurent | (Phase 4) | Placeholder, to be replaced with Japanese names |
| Cardiology / General Medicine / Support | 循環器内科 / 一般内科 / 受付サポート | Specialties in the seeded data |
