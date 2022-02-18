struct WikipediaExpectation {
    title: String,
    charset: String,
}

#[cfg(test)]
mod tests {
    use crate::WikipediaExpectation;
    use kuchiki::traits::TendrilSink;
    use std::fs;
    use std::io::Read;

    #[test]
    fn run_test() {
        let html = load_wikipedia_html();
        let document = kuchiki::parse_html().one(html);
        let expectation = load_expectations();
        let start_time = std::time::Instant::now();

        for _ in 0..10_000 {
            let title_element = document.select("title").unwrap().next().unwrap();
            let title_text = title_element.text_contents();
            assert_eq!(title_text, expectation.title);

            let meta_element = document.select("meta[charset]").unwrap().next().unwrap();
            let attributes = meta_element.attributes.borrow();
            if let Some(meta_charset_attribute) = attributes.get("charset") {
                assert_eq!(meta_charset_attribute, expectation.charset);
            } else {
                panic!("No charset attribute found");
            }
        }

        let end_time = std::time::Instant::now();
        let duration = end_time.duration_since(start_time).as_millis();
        print!("Duration: {}", duration);
        // write duration to result.txt

        let duration_str = format!("{}", duration);
        fs::write("target/result.txt", duration_str).unwrap();
    }

    fn load_wikipedia_html() -> String {
        let mut file =
            std::fs::File::open("../fixtures/wikipedia/wikipedia_on_wikipedia.html").unwrap();
        let mut html = String::new();
        file.read_to_string(&mut html).unwrap();
        return html;
    }

    fn load_expectations() -> WikipediaExpectation {
        // read file named wikipedia.html
        let mut title_file = std::fs::File::open("../fixtures/wikipedia/title.txt").unwrap();
        let mut title = String::new();
        title_file.read_to_string(&mut title).unwrap();

        let mut charset_file = std::fs::File::open("../fixtures/wikipedia/charset.txt").unwrap();
        let mut charset = String::new();
        charset_file.read_to_string(&mut charset).unwrap();

        return WikipediaExpectation {
            title: title,
            charset: charset,
        };
    }
}
