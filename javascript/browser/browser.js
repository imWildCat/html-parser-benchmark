import { chromium, webkit, firefox } from 'playwright';
import fs from 'fs';

async function testBrowser(browserType, outputFile) {
  const wikepediaHTML = fs.readFileSync('../fixtures/wikipedia/wikipedia_on_wikipedia.html', 'utf8');
  const titleExpectation = fs.readFileSync('../fixtures/wikipedia/title.txt', 'utf-8');
  const charsetExpectation = fs.readFileSync('../fixtures/wikipedia/charset.txt', 'utf-8');

  const expectation = {
    title: titleExpectation,
    charset: charsetExpectation,
  }

  const browser = await browserType.launch();

  const page = await browser.newPage();

  await page.setContent(wikepediaHTML, { waitUntil: 'networkidle' });

  const duration = await page.evaluate(([expectation]) => {
    const max = 10_000;

    const start = Date.now();

    for (let i = 0; i < max; i++) {
      const titleElement = window.document.querySelector('title');
      const title = titleElement.textContent;
      if (expectation.title !== title) {
        throw new Error(`Title is not as expected: ${title}`);
      }
      const charsetElement = window.document.querySelector('meta[charset]');
      const charset = charsetElement.getAttribute('charset');
      if (expectation.charset !== charset) {
        throw new Error(`Charset is not as expected: ${charset}`);
      }
    }
    const end = Date.now();

    const duration = end - start;

    return duration;
  }, [expectation]);

  await page.close();
  await browser.close();

  console.log('Closed page and browser');

  console.log(`duration [${outputFile}]:`, duration);

  fs.writeFileSync(outputFile, `${duration}`);
}

async function main() {
  await testBrowser(chromium, './chromium.txt');
  await testBrowser(webkit, './webkit.txt');
  await testBrowser(firefox, './firefox.txt');
}

main();
