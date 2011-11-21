require "rqrcode_to_svg/version"

require 'rubygems'
require 'rqrcode'

module RQRCode
  class QRCode

    def to_svg( *args )
      
      # Options.
      
      # The :border option sets the border around the QR code.
        # true adds a default border, with a size of four QR Code-points.
        # false adds no border. This is the default.
        # Or, enter a number (as a measure of QR Code-points) to set your own custom border size.
        
      # The :px option determines the size of each QR Code-point in pixels. The default is 4 pixels.
      # Throughout the conversion, we'll multiply each QR Code-point by this :px value.
      
      # The :file option sets the path to which the SVG file will be written. 
        # If set to false (default), the SVG XML will be returned as a string.
        
      # The :namespace option is a boolean that adds the "svg" XML namespace prefix. Default is false.
      
      # The :indent option is used to pretty print the XML. Defaults to false.
        # false gives a tag soup with no line breaks.
        # true adds line breaks and indents each child element by two spaces.
        # A String object adds line breaks and will be used as the literal indentation.
        # A number adds line breaks and will be interpreted as the number of spaces to indent.
      
      options = args.extract_options!
      border = options[:border] || false
      px_multiplier = options[:px] || 4
      file = options[:file] || false
      namespace = options[:namespace] || false
      indent = options[:indent] || false
      
      # The following case evaluates the :border option. Goal: to set the length of the border.
      border_length = 0
      case border
        when TrueClass
          border_length = 4 * px_multiplier
        when String, Numeric
          border_length = border.to_i * px_multiplier
      end
      
      # The following case evaluates the :indent option. Goal: to pretty print the XML if desired.
      indentation = String.new
      case indent
        when TrueClass
          indentation = " " * 2
        when String
          indentation = indent
        when Numeric
          indentation = " " * indent
      end
      
      # qr_side_length calculates the side length of the QR code *without the border*.
      qr_side_length = px_multiplier * @module_count
      
      # total_side_length calculates the side length of the QR code with the border included.
      total_side_length = qr_side_length + (border_length * 2)
      
      # Find all of the "dark" points within the QR code.
      # For each dark point, add a <rect/> SVG XML element (as a String) to the svg_squares array.
      svg_squares = Array.new
      @modules.each_index do |y|
        @modules.each_index do |x|
          if dark?(y,x)
            svg_squares.push("#{indentation}<#{"svg:" if namespace}rect x='#{(border_length + (px_multiplier * x))}px' y='#{(border_length + (px_multiplier * y))}px' width='#{px_multiplier}px' height='#{px_multiplier}px' style='fill:rgb(0,0,0)'/>#{"\n" if indent}")
          end
        end
      end
      
      # Constuct the SVG XML. 
      svg = "<#{"svg:" if namespace}svg xmlns#{":svg" if namespace}='http://www.w3.org/2000/svg' version='1.1' baseProfile='full' width='#{total_side_length}px' height='#{total_side_length}px'>#{"\n" if indent}#{svg_squares.join}</#{"svg:" if namespace}svg>"
      
      # Checks the file option.
      # If a path is given, write the SVG to the file and return the path.
      # If a path is not given, return the SVG as a string.
      if file
        File.open(file, 'w') do |file| 
          file.write(("<?xml version='1.0' encoding='UTF-8'?>\n" + svg))
        end
        return file
      else
        return svg
      end
      
    end
    
  end
end