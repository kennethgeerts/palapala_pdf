# frozen_string_literal: true

require_relative 'test_helper'
require 'benchmark'

class TestPdf < Minitest::Test
  def setup
    Palapala.setup do |config|
      config.ferrum_opts = { url: 'http://localhost:9222' }
      config.defaults.merge! scale: 1, format: :A4
      puts "defaults = #{config.defaults}"
    end
  end

  def test_create_pdf_from_html
    # Create a page
    pdf = Palapala::PDF.new("<h1>Hello, world! #{Time.now}</h1>")

    # pdf = Palapala::PDF.new("<h1>Hello, world! #{Time.now}</h1>", header: "<h1>Header</h1>", footer: "<h1>Footer</h1>")
    # pdf = Palapala::PDF.new(url: "http://www.google.com", header: "<h1>Header</h1>", footer: "<h1>Footer</h1>")
    # pdf_binary_data = pdf.binary_data
    # pdf.save("tmp/test_page.pdf")

    # Create a PDF from the HTML content
    binary_data = pdf.binary_data

    # Validate the PDF content
    assert binary_data.start_with?('%PDF-1.4')
  end
end
