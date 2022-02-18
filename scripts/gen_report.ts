import fs from 'fs';

const rust = fs.readFileSync('../rust/target/result.txt', 'utf8');
const go = fs.readFileSync('../golang/result.txt', 'utf8');
const swiftLibXml = fs.readFileSync('../swift/.build/kanna.txt', 'utf8');
const swiftPure = fs.readFileSync('../swift/.build/swiftsoup.txt', 'utf8');

// JavaScript
const nodejs = fs.readFileSync('../javascript/node.txt', 'utf8');
const chromium = fs.readFileSync('../javascript/chromium.txt', 'utf8');
const webkit = fs.readFileSync('../javascript/webkit.txt', 'utf8');
const firefox = fs.readFileSync('../javascript/firefox.txt', 'utf8');

const result: Record<string, string> = {
  'Rust (kuchiki, html5ever)': `${rust}ms`,
  'Go (goquery)': `${go}ms`,
  'Swift (Kanna, libxml2)': `${swiftLibXml}ms`,
  'Swift (SwiftSoup)': `${swiftPure}ms`,
  'JavaScript (Node.js, jsdom)': `${nodejs}ms`,
  'JavaScript (Chromium)': `${chromium}ms`,
  'JavaScript (WebKit)': `${webkit}ms`,
  'JavaScript (Firefox)': `${firefox}ms`,
}

const keys = Object.keys(result);

let output = `| Language | Duration |
|-------|------|
`

keys.forEach((key) => {
  output += `| ${key} | ${result[key]} |\n`
})

console.log(output);