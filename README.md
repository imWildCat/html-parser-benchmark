# HTML Parser Benchmark of Go, JavaScript, Rust and Swift

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
