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

### GitHub Actions (Ubuntu)

| Language | Duration |
|-------|------|
| Rust (kuchiki, html5ever) | 13ms |
| Go (goquery) | 9022ms |
| Swift (Kanna, libxml2) | 19228.30ms |
| Swift (SwiftSoup) | 213742.24ms |
| JavaScript (Node.js, jsdom) | 360ms |
| JavaScript (Chromium) | 11ms |
| JavaScript (WebKit) | 4ms |
| JavaScript (Firefox) | 9ms |

### GitHub Actions (macOS)

| Language | Duration |
|-------|------|
| Rust (kuchiki, html5ever) | 20ms |
| Go (goquery) | 9212ms |
| Swift (Kanna, libxml2) | 22269.05ms |
| Swift (SwiftSoup) | 220971.89ms |
| JavaScript (Node.js, jsdom) | 742ms |
| JavaScript (Chromium) | 13ms |
| JavaScript (WebKit) | 7ms |
| JavaScript (Firefox) | 8ms |

## License

MIT
