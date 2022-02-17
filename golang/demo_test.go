package main

import (
	"io/ioutil"
	"strconv"
	"strings"
	"testing"
	"time"

	"github.com/PuerkitoBio/goquery"
)

func TestDemo(t *testing.T) {
	// string to reader
	reader := strings.NewReader(loadWikipediaHTML(t))
	doc, err := goquery.NewDocumentFromReader(reader)
	if err != nil {
		t.Fatal(err)
	}
	expectation := loadWikipediaExpectation(t)

	startTime := time.Now()

	for i := 0; i < 10_000; i++ {
		title := doc.Find("title").Text()
		charset := doc.Find("meta[charset]").AttrOr("charset", "")

		// assert equal
		if title != expectation.title {
			t.Errorf("title should be %s, but %s", expectation.title, title)
		}
		if charset != expectation.charset {
			t.Errorf("charset should be %s, but %s", expectation.charset, charset)
		}
	}

	endTime := time.Now()

	duration := endTime.Sub(startTime)

	t.Logf("duration: %dms\n", duration.Milliseconds())

	err = ioutil.WriteFile("result.txt", []byte(strconv.Itoa(int(duration.Milliseconds()))), 0644)
	if err != nil {
		t.Fatal(err)
	}
}

func loadWikipediaHTML(t *testing.T) string {
	fileData, err := ioutil.ReadFile("../fixtures/wikipedia/wikipedia_on_wikipedia.html")
	if err != nil {
		t.Fatal(err)
	}
	return string(fileData)
}

func loadWikipediaExpectation(t *testing.T) *WikipediaExpectation {
	titleData, err := ioutil.ReadFile("../fixtures/wikipedia/title.txt")
	if err != nil {
		t.Fatal(err)
	}

	charsetData, err := ioutil.ReadFile("../fixtures/wikipedia/charset.txt")
	if err != nil {
		t.Fatal(err)
	}

	return &WikipediaExpectation{
		title:   string(titleData),
		charset: string(charsetData),
	}
}

type WikipediaExpectation struct {
	title   string
	charset string
}
