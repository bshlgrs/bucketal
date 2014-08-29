require "erb"
# require "wicked_pdf"

template_string = %{
<h1><%= title %></h1>
<pre>
<%= newcontents %>
</pre>
}

template = ERB.new template_string

Dir.mkdir("output_htmls") unless Dir.exists? "output_htmls"
# Dir.mkdir("output_pdfs") unless Dir.exists? "output_pdfs"

Dir.entries(Dir.pwd).each do |infile|
    next unless infile =~ /.*\.chords/

    title = File.read(infile).lines.first
    contents = File.read(infile).lines[1..-1].join("")

    newcontents = ""
    contents.lines.each do |line|
        if line.strip[-1]==":" or line.strip[-1]=="."
            newcontents+="<b>#{line.strip}</b>\n"
        else
            newcontents+=line
        end
    end

    html_string = template.result(binding)

    File.open("output_htmls/#{infile[0..-8]}.html",'w') do |outfile|
        outfile.puts(html_string)
    end

    # pdf = WickedPdf.new.pdf_from_string(html_string)

    # File.open("output_pdfs/#{infile[0..-8]}.pdf",'w') do |pdffile|
    #     pdffile << pdf
    # end

end