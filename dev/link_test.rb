require 'nokogiri'
require 'csv'

# Function to process an HTML file and extract modified links
def process_html_file(file_path, csv)
  # Read the HTML content from the file
  content = File.read(file_path)

  # Parse the HTML content using Nokogiri
  doc = Nokogiri::HTML(content)

  # Iterate over all <a> tags with href attributes
  doc.css('a[href]').each do |link|
    original_href = link['href']
    modified_href = original_href

    # Modify the href attribute based on the plugin's logic
    unless original_href.end_with?('.html') || original_href.start_with?('#', 'http', '//')
      modified_href += '.html'
    end

    # Add the original and modified links to the CSV file
    csv << [original_href, modified_href]
  end
end

# Function to traverse a folder and process HTML files
def traverse_folder(folder_path, output_file)
  # Open a CSV file for writing
  CSV.open(output_file, 'w') do |csv|
    # Use Dir.glob to find all HTML files in the folder and its subfolders
    Dir.glob("#{folder_path}/**/*.html") do |file|
      # Exclude the _site folder from traversal
      next if file.include?('_site/')

      # Process each HTML file
      process_html_file(file, csv)
    end
  end
end

# Provide the folder path containing the HTML files you want to test
folder_path = '/home/febres/Documents/temp/morel-theme-2.0'

# Provide the output file path for the CSV file
output_file = './output.csv'

# Traverse the folder and process HTML files, exporting the result to the CSV file
traverse_folder(folder_path, output_file)
