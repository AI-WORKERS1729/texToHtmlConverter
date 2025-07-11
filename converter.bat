@echo off
setlocal enabledelayedexpansion

:: Check if at least one argument (input file) is provided
if "%~1"=="" (
    echo Usage: %~nx0 filename.tex [options]
    echo.
    echo Options:
    echo   -o output.html    Specify output filename
    echo   -p packages       Specify additional packages (comma-separated)
    echo   -f format         Specify format (default: html5)
    echo   -m math           Specify math renderer (default: mathjax)
    echo   -c config         Additional make4ht configuration
    echo   -h, --help        Show this help message
    echo.
    echo Examples:
    echo   %~nx0 document.tex
    echo   %~nx0 document.tex -o myfile.html
    echo   %~nx0 document.tex -p "svg,pic-align" -m mathjax
    echo   %~nx0 document.tex -f html5 -c "early_filter"
    exit /b 1
)

:: Initialize variables
set "input_file=%~1"
set "output_file="
set "packages=mathjax"
set "format=html5"
set "math_renderer=mathjax"
set "config="
set "additional_options="

:: Check if input file exists
if not exist "%input_file%" (
    echo Error: Input file "%input_file%" not found.
    exit /b 1
)

:: Extract filename without extension for default output
for %%F in ("%input_file%") do set "base_name=%%~nF"

:: Parse command line arguments
shift
:parse_args
if "%~1"=="" goto end_parse

if /i "%~1"=="-o" (
    set "output_file=%~2"
    shift
    shift
    goto parse_args
)

if /i "%~1"=="-p" (
    set "packages=%~2"
    shift
    shift
    goto parse_args
)

if /i "%~1"=="-f" (
    set "format=%~2"
    shift
    shift
    goto parse_args
)

if /i "%~1"=="-m" (
    set "math_renderer=%~2"
    shift
    shift
    goto parse_args
)

if /i "%~1"=="-c" (
    set "config=%~2"
    shift
    shift
    goto parse_args
)

if /i "%~1"=="-h" goto show_help
if /i "%~1"=="--help" goto show_help

:: Handle unknown arguments
echo Warning: Unknown argument "%~1" ignored.
shift
goto parse_args

:show_help
echo Advanced LaTeX to HTML Converter
echo.
echo Usage: %~nx0 filename.tex [options]
echo.
echo Options:
echo   -o output.html    Specify output filename (default: filename.html)
echo   -p packages       Specify packages for make4ht (default: mathjax)
echo                     Common packages: mathjax, svg, pic-align, early_filter
echo   -f format         Specify output format (default: html5)
echo                     Options: html5, xhtml, odt, tex4ebook
echo   -m math           Specify math renderer (default: mathjax)
echo                     Options: mathjax, mathml, tex4ht
echo   -c config         Additional make4ht configuration options
echo   -h, --help        Show this help message
echo.
echo Package combinations:
echo   mathjax           - Use MathJax for math rendering
echo   mathjax,svg       - MathJax + SVG images
echo   mathjax,pic-align - MathJax + picture alignment
echo   mathml            - Use MathML for math
echo   svg,pic-align     - SVG images with alignment
echo.
echo Examples:
echo   %~nx0 document.tex
echo   %~nx0 document.tex -o output/index.html
echo   %~nx0 document.tex -p "mathjax,svg" -f html5
echo   %~nx0 document.tex -m mathml -p "pic-align"
echo   %~nx0 document.tex -c "early_filter" -p "mathjax,svg"
exit /b 0

:end_parse

:: Set default output file if not specified
if "%output_file%"=="" set "output_file=%base_name%.html"

:: Build the make4ht command
set "cmd=make4ht -u -f %format%"

:: Add output file option
set "cmd=%cmd% -d "%~dp0""

:: Add configuration if specified
if not "%config%"=="" set "cmd=%cmd% -c %config%"

:: Add input file
set "cmd=%cmd% "%input_file%""

:: Add packages
if not "%packages%"=="" set "cmd=%cmd% "%packages%""

:: Show the command being executed
echo Executing: %cmd%
echo.
echo Input file: %input_file%
echo Output file: %output_file%
echo Format: %format%
echo Packages: %packages%
if not "%config%"=="" echo Config: %config%
echo.

:: Execute the command
%cmd%

:: Check if conversion was successful
if %errorlevel% equ 0 (
    echo.
    echo Conversion completed successfully!
    
    :: Rename output if different from default
    if not "%output_file%"=="%base_name%.html" (
        if exist "%base_name%.html" (
            move "%base_name%.html" "%output_file%" >nul 2>&1
            if %errorlevel% equ 0 (
                echo Output renamed to: %output_file%
            ) else (
                echo Warning: Could not rename output file.
                echo Output available as: %base_name%.html
            )
        )
    )
    
    :: List generated files
    echo.
    echo Generated files:
    if exist "%output_file%" echo   - %output_file%
    if exist "%base_name%.css" echo   - %base_name%.css
    if exist "%base_name%.lg" echo   - %base_name%.lg (log file)
    
) else (
    echo.
    echo Error: Conversion failed with exit code %errorlevel%
    echo Check the log files for details.
)

endlocal