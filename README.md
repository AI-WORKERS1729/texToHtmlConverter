# LaTeX to HTML Converter - Instructions

## Overview

The `converter.bat` is an advanced batch file that provides a flexible interface for converting LaTeX documents to HTML using the `make4ht` tool. It supports various output formats, math rendering options, and customizable packages.

## Basic Usage

```bash
converter.bat filename.tex [options]
```

### Simple Examples

```bash
# Basic conversion (creates filename.html)
converter.bat document.tex

# Convert with custom output name
converter.bat document.tex -o mypage.html

# Convert your Q&A template
converter.bat qa_template.tex -o questions.html
```

## Command Line Options

### `-o output.html` - Output File
Specify the output filename. If not provided, uses `filename.html` as default.

```bash
converter.bat document.tex -o output.html
converter.bat document.tex -o web/index.html    # Output to subdirectory
converter.bat document.tex -o ../output.html    # Output to parent directory
```

### `-p packages` - Package Configuration
Specify packages for make4ht conversion (comma-separated, no spaces).

**Common Packages:**
- `mathjax` - Use MathJax for math rendering (default)
- `svg` - Convert images to SVG format
- `pic-align` - Enable picture alignment
- `mathml` - Use MathML for math rendering
- `early_filter` - Apply early filtering

```bash
converter.bat document.tex -p "mathjax"
converter.bat document.tex -p "mathjax,svg"
converter.bat document.tex -p "mathml,pic-align"
converter.bat document.tex -p "svg,pic-align"
```

### `-f format` - Output Format
Specify the output format (default: html5).

**Available Formats:**
- `html5` - HTML5 format (default)
- `xhtml` - XHTML format
- `odt` - OpenDocument Text format
- `tex4ebook` - E-book format

```bash
converter.bat document.tex -f html5
converter.bat document.tex -f xhtml
converter.bat document.tex -f odt
```

### `-m math` - Math Renderer
Specify the math rendering method (default: mathjax).

**Available Options:**
- `mathjax` - MathJax rendering (default)
- `mathml` - MathML rendering
- `tex4ht` - tex4ht rendering

```bash
converter.bat document.tex -m mathjax
converter.bat document.tex -m mathml
converter.bat document.tex -m tex4ht
```

### `-c config` - Additional Configuration
Specify additional make4ht configuration options.

```bash
converter.bat document.tex -c "early_filter"
converter.bat document.tex -c "custom_config"
```

### `-h, --help` - Help
Display comprehensive help information.

```bash
converter.bat -h
converter.bat --help
```

## Advanced Examples

### High-Quality Math with SVG Images
```bash
converter.bat qa_template.tex -p "mathjax,svg" -o math_questions.html
```

### Complete Custom Configuration
```bash
converter.bat document.tex -o output/index.html -p "mathjax,svg,pic-align" -f html5 -c "early_filter"
```

### MathML for Accessibility
```bash
converter.bat document.tex -m mathml -p "pic-align" -o accessible.html
```

### Multiple Format Output
```bash
# HTML version
converter.bat document.tex -f html5 -o web/document.html

# XHTML version
converter.bat document.tex -f xhtml -o web/document.xhtml

# ODT version for word processing
converter.bat document.tex -f odt -o document.odt
```

## Package Combinations Guide

### Recommended Combinations

#### For Web Display
```bash
converter.bat file.tex -p "mathjax,svg,pic-align"
```
- **Best for:** General web pages with math
- **Features:** MathJax math, SVG images, proper alignment

#### For Accessibility
```bash
converter.bat file.tex -p "mathml,pic-align" -m mathml
```
- **Best for:** Screen readers and accessibility
- **Features:** MathML math, proper image alignment

#### For High Performance
```bash
converter.bat file.tex -p "svg,pic-align"
```
- **Best for:** Fast loading pages
- **Features:** SVG images, no external math dependencies

#### For Simple Documents
```bash
converter.bat file.tex -p "mathjax"
```
- **Best for:** Text-heavy documents with minimal math
- **Features:** Basic MathJax rendering

## Output Files

The converter generates several files:

### Primary Output
- `filename.html` (or custom name) - Main HTML file

### Supporting Files
- `filename.css` - Stylesheet for formatting
- `filename.lg` - Log file with conversion details
- Additional image files (if any)

## Error Handling

### Common Issues and Solutions

#### Input File Not Found
```
Error: Input file "document.tex" not found.
```
**Solution:** Check the filename and path are correct.

#### Conversion Failed
```
Error: Conversion failed with exit code 1
```
**Solution:** Check the log files (`.lg` extension) for detailed error information.

#### Missing Dependencies
Ensure you have:
- TeX Live or MiKTeX installed
- `make4ht` package available
- Required LaTeX packages in your document

## Examples for Your Q&A Template

### Basic Conversion
```bash
converter.bat qa_template.tex
# Output: qa_template.html
```

### Professional Web Version
```bash
converter.bat qa_template.tex -o ring_theory_questions.html -p "mathjax,svg,pic-align"
```

### Mobile-Friendly Version
```bash
converter.bat qa_template.tex -o mobile/questions.html -p "mathjax,pic-align" -f html5
```

### Accessible Version
```bash
converter.bat qa_template.tex -o accessible_questions.html -p "mathml,pic-align" -m mathml
```

## Tips and Best Practices

### 1. File Organization
- Keep your `.tex` files and converter in the same directory
- Use subdirectories for different output formats
- Maintain clean file naming conventions

### 2. Package Selection
- Use `mathjax,svg` for the best visual quality
- Use `mathml` for accessibility compliance
- Add `pic-align` for documents with images or diagrams

### 3. Testing Different Formats
```bash
# Test HTML5
converter.bat document.tex -f html5 -o test/html5.html

# Test XHTML
converter.bat document.tex -f xhtml -o test/xhtml.html

# Compare results
```

### 4. Batch Processing
Create a simple script to convert multiple files:
```bash
converter.bat chapter1.tex -o output/chapter1.html
converter.bat chapter2.tex -o output/chapter2.html
converter.bat chapter3.tex -o output/chapter3.html
```

## Troubleshooting

### Verbose Output
The converter shows detailed information during execution:
- Input and output filenames
- Selected format and packages
- Configuration options
- Generated files list

### Log Files
Check `.lg` files for detailed conversion logs and error messages.

### Common LaTeX Package Issues
Some LaTeX packages may not convert well to HTML. Consider:
- Using standard packages when possible
- Testing conversion with minimal documents first
- Checking make4ht documentation for package compatibility

## Version Information

This converter script supports:
- **make4ht** - Primary conversion engine
- **HTML5/XHTML** - Web formats
- **MathJax/MathML** - Math rendering
- **SVG** - High-quality images
- **Custom configurations** - Advanced options

For the latest make4ht documentation and package options, visit the official TeX Live documentation.
