# 4D AIKitのツール呼び出しによるAI予約受付システム

AI-Powered Appointment Booking with Tool Calling in 4D AIKit (Technical Note 26-08): Japanese edition.

このテクニカルノートでは、キーワードに基づく意図の解析を手作業で実装する代わりに、4D AIKitのツール呼び出し（tool calling）を利用してAIアシスタントを構築する方法を説明します。デモのdemoAPTは、架空の「はやぶさクリニック」の予約受付システムです。空き状況の確認、予約、予約の変更、キャンセル、照会といった操作をOpenAIツールとして公開し、公開Webチャットから自然な日本語で利用できます。同じビジネスメソッドは、スタッフ用のネイティブ管理フォームからもAIを介さずに直接呼び出せます。ツールの定義、ディスパッチ、会話ループ、そしてセキュリティとコストの管理まで、パターン全体を順に解説します。

This technical note explains how to build an AI assistant in 4D with tool calling instead of hand-written intent parsing. The demo is the booking system of a fictional clinic: booking operations are exposed as OpenAI tools to a public web chat, and the same business methods are called directly from a native admin form.

## Download

| | |
|---|---|
| PDF (Japanese) | [26-08_BookingWithAI_ja.pdf](https://github.com/miyako/BookingWithAI/releases/latest/download/26-08_BookingWithAI_ja.pdf) |
| 4D demo | [BookingWithAI.zip](https://github.com/miyako/BookingWithAI/releases/latest/download/BookingWithAI.zip) |
| Original (English) | `document/26-08_BookingWithAI.pdf` |

## Demo

- 4D version: 4D 21 R3 or later (the AIKit provider settings file `Project/Sources/AIProviders.json` is read from 4D 21 R3).
- Open `demo/BookingWithAI/Project/BookingWithAI.4DProject`.
- Languages: English and Japanese. The UI follows the system language; the XLIFF files are in `Resources/<lang>.lproj/`. The web chat pages (`WebFolder/`) are Japanese only.
- API key: copy `Project/Sources/AIProviders.example.json` to `Project/Sources/AIProviders.json` and enter your OpenAI key (or edit it on the AI page of the Structure Settings). This file is ignored by git; never commit it.
- At startup the splash window opens without blocking (worker process 1). Run `APT_Seed` to reset the sample data before following the demo script in section 5.5 (デモ).

### Demo data

The sample staff, patients and appointments created by `APT_Seed` were replaced with Japanese equivalents (doctors 田中 健一, 佐藤 美咲 and 鈴木 大輔 at はやぶさクリニック, patients such as 高橋 結衣, and Japanese appointment reasons). Names are stored family name first; patient lookup accepts either name order, with or without a space, and phone numbers with or without the country code.

## Differences from the original

- Demo data, examples and figure 2 use the Japanese names above; the chat examples are in Japanese.
- Screenshots of the web chat and the admin form (figures 4 to 10) were retaken with the localised demo. Figure 3 (database structure) is the original.
- The model name in figure 1 is GPT-5, consistent with the text.
- The demo: XLIFF localisation of forms, menus and messages (English and Japanese); a computed `statusLabel` attribute for the appointment status; non-blocking startup; a system-prompt rule to reply in Japanese.
- The API key is read from `Project/Sources/AIProviders.json` (the 4D AIKit provider settings) instead of `Resources/AIProvider.json`.
- Bug fix: several tools returned the literal text `"HH:mm"` instead of the appointment time; they now return times such as `"11:40"`.

## Editing and rebuilding

The PDF is generated from plain-text sources. Edit them and run `make`.

| File | What |
|---|---|
| `src/ja.md` | Translated body text. **Don't touch code blocks** (`make check` verifies them). |
| `figures/fig-NN.ja.txt` | Text drawn in figure NN. Line N corresponds to line N of `fig-NN.en.txt`: an identical line keeps the original, an empty line erases it. |
| `figures/layout/fig-NN.json` | Per-label overrides for size, weight, alignment and position; `"replace"` uses a ready-made image |
| `glossary.md` | Terminology |

```sh
make            # check → figures → build/26-08_BookingWithAI_ja.pdf
make check      # code blocks unchanged, figure references complete
make review     # contact sheets of the figures (build/contact-N.png)
make release-assets
```

Requirements: Python 3, Google Chrome, CJK fonts, and Tesseract (only needed for re-extraction).
See the [localisation template](https://github.com/miyako/4d-technote-localisation-template) for the full workflow.

## Credits

- Original: Soukaina Bachikh, Customer Success Engineer, 4D Inc.
- Translation: miyako
- Produced with [4d-technote-localisation-template](https://github.com/miyako/4d-technote-localisation-template) and GitHub Copilot.
