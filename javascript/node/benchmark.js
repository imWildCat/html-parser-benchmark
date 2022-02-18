import fs from 'fs';
import { JSDOM } from 'jsdom';

const wikepediaHTML = fs.readFileSync('../fixtures/wikipedia/wikipedia_on_wikipedia.html', 'utf8');
const titleExpectation = fs.readFileSync('../fixtures/wikipedia/title.txt', 'utf-8');
const charsetExpectation = fs.readFileSync('../fixtures/wikipedia/charset.txt', 'utf-8');

const expectation = {
  title: titleExpectation,
  charset: charsetExpectation,
}

const dom = new JSDOM(wikepediaHTML);

const max = 10_000;

const start = Date.now();

for (let i = 0; i < max; i++) {
  const titleElement = dom.window.document.querySelector('title');
  const title = titleElement.textContent;
  if (expectation.title !== title) {
    throw new Error(`Title is not as expected: ${title}`);
  }
  const charsetElement = dom.window.document.querySelector('meta[charset]');
  const charset = charsetElement.getAttribute('charset');
  if (expectation.charset !== charset) {
    throw new Error(`Charset is not as expected: ${charset}`);
  }
}

const end = Date.now();

const duration = end - start;

console.log('duration:', duration);

fs.writeFileSync('node.txt', `${duration}`);
