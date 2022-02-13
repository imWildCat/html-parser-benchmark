
#[cfg(test)]
mod tests {
    use html5ever::{ParseOpts, tendril::TendrilSink};
    use markup5ever_rcdom::RcDom;

    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert_eq!(result, 4);
        
        let opts = ParseOpts::default();
        let dom = html5ever::parse_document(RcDom::default(), opts).one("<h1>Head 1</h1>");

        let doc = &dom.document;

        assert_eq!(doc.children.borrow().len(), 1);
    }
}
