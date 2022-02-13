#[cfg(test)]
mod tests {
    use kuchiki::traits::TendrilSink;
    use std::{borrow::Borrow, io::Read};

    use crate::WikipediaExpectation;

    #[test]
    fn it_works() {
        let html = load_wikipedia_html();
        let document = kuchiki::parse_html().one(html);
        let expectation = load_expectations();

        let css_selector = "title";

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

        for css_match in document.select(css_selector).unwrap() {
            // css_match is a NodeDataRef, but most of the interesting methods are
            // on NodeRef. Let's get the underlying NodeRef.
            let as_node = css_match.as_node();

            // In this example, as_node represents an HTML node like
            //
            //   <p class='foo'>Hello world!</p>"
            //
            // Which is distinct from just 'Hello world!'. To get rid of that <p>
            // tag, we're going to get each element's first child, which will be
            // a "text" node.
            //
            // There are other kinds of nodes, of course. The possibilities are all
            // listed in the `NodeData` enum in this crate.
            let text_node = as_node.first_child().unwrap();

            // Let's get the actual text in this text node. A text node wraps around
            // a RefCell<String>, so we need to call borrow() to get a &str out.
            let text = text_node.as_text().unwrap().borrow();

            // Prints:
            //
            //  "Hello, world!"
            //  "I love HTML"
            println!("{:?}", text);
        }
    }

    fn load_wikipedia_html() -> String {
        // read file named wikipedia.html
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

struct WikipediaExpectation {
    title: String,
    charset: String,
}
