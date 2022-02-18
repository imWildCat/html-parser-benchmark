# HTML Parser Benchmark of Go, JavaScript, Rust and Swift

## Design

This benchmark is designed to measure the performance of HTML parsing libraries of different programming languages.
The only fixture at this moment is the HTML source code of <http://en.wikipedia.org/wiki/Wikipedia>. It is about 1.0 Megabytes in size.

Only using CSS Selector to find HTML elements is currently tested in this benchmark. The repeat time is current `10,000` (10k).

## Results

### Apple M1 Max

| Language | Duration |
|-------|------|
| Rust (kuchiki, html5ever) | 8ms |
| Go (goquery) | 5631ms |
| Swift (Kanna, libxml2) | 6329.33ms |
| Swift (SwiftSoup) | 128598.36ms |
| JavaScript (Node.js, jsdom) | 141ms |
| JavaScript (Chromium) | 11ms |
| JavaScript (WebKit) | 5ms |
| JavaScript (Firefox) | 4ms |

## License

MIT
