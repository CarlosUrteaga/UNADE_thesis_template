% Tesis UNADE CLASS -- version 0.1
% Clase para las tesis del UNADE
% 
% 2025 09 02 Carlos Urteaga carlos(dot)urteaga (at) outlook (dot) com
% LICENSE: Creative Commons SA-BY 3.0
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{tesisUNADE}[2015/04/13 v0.01 Template para tesis UNADE]


%%%%%%%%%%%%%%%%%%%%%%%%%% Opcion para declarar tesina %%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\@thesis{TESIS}
\DeclareOption{tesina}{\renewcommand{\@thesis}{TESINA}}

\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{report}%
}

\ProcessOptions\relax

% Usamos como clase base el de report
\LoadClass{report}

%Paquetes requeridos
\RequirePackage{iftex}
\RequirePackage{graphicx}
\RequirePackage{amsopn}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{tocloft}

\RequirePackage{tikz}
\RequirePackage{verbatim}

% Utilizamos babel para el manejo de idiomas
\PassOptionsToPackage{english}{babel}
\PassOptionsToPackage{spanish,es-tabla,es-nodecimaldot}{babel}
\RequirePackage{babel}

% Idioma principal de la tesis; por defecto se mantiene espanol.
\newcommand{\UNADE@thesislanguage}{spanish}
\newcommand{\thesislanguage}[1]{\renewcommand{\UNADE@thesislanguage}{#1}}
\newcommand{\applythesislanguage}{\selectlanguage{\UNADE@thesislanguage}}

\addto\captionsspanish{%
  \renewcommand{\contentsname}{Tabla de contenido}%
  \renewcommand{\listfigurename}{Tabla de figuras}%
  \renewcommand{\listtablename}{Tabla de tablas}%
  \renewcommand{\bibname}{Referencias}%
}

\addto\captionsenglish{%
  \renewcommand{\contentsname}{Table of contents}%
  \renewcommand{\listfigurename}{List of figures}%
  \renewcommand{\listtablename}{List of tables}%
  \renewcommand{\bibname}{References}%
}

% Aproxima el documento base de Word: carta, margenes de 1 in y Times.
\geometry{letterpaper,margin=1in}
\newlength{\UNADEHeaderLogoHeight}
\setlength{\UNADEHeaderLogoHeight}{20mm}
\setlength{\headheight}{\dimexpr\UNADEHeaderLogoHeight+4pt\relax}
\setlength{\headsep}{12pt}
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage{mathptmx}
\else
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
  \IfFontExistsTF{Times New Roman}{%
    \setmainfont{Times New Roman}%
  }{%
    % Fallback portable para Linux/CI/Overleaf sin fuentes Microsoft.
    \RequirePackage{newtxtext}%
  }
\fi

%Requerimos las definiciones adicionales
\RequirePackage{macros}


\newcommand{\UNADE@wmfile}{UNADELogo.jpg}     % default file name
\newcommand{\setwatermark}[1]{\renewcommand{\UNADE@wmfile}{##1}}

% Define "add watermark" and enable/disable commands
\newcommand{\UNADE@addwatermark}{%
  \AddToShipoutPictureBG{%
    \begin{tikzpicture}[remember picture,overlay]
      % tweak xshift/yshift, width, and opacity to taste
      \node[
        anchor=north west,
        opacity=1,
        xshift=12mm,
        yshift=-12mm
      ] at (current page.north west) {%
        \includegraphics[width=25mm]{\UNADE@wmfile}%
      };
    \end{tikzpicture}%
  }%
}
\newcommand{\EnableWatermark}{\ClearShipoutPictureBG\UNADE@addwatermark}
\newcommand{\DisableWatermark}{\ClearShipoutPictureBG}

%%%%%%%%%%%%%%%%%%%%%%%%%% Espaciados %%%%%%%%%%%%%%%%%%%%%%%%%%
\parindent 0pt
\parskip 1ex
\setstretch{2}

%%%%%%%%%%%%%%%%% Usar numeros romanos en las subsecciones %%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\thesubsubsection{\Roman{subsubsection}}
\setcounter{secnumdepth}{3}

%%%%%%%%%%%%%%%%%%%%%%%%%% Titulos y preliminares %%%%%%%%%%%%%%%%%%%%%%%%%%
% El .docx usa Titulo 1 centrado y en negritas; los niveles siguientes son
% progresivamente mas compactos y alineados a la izquierda.
\titleformat{\chapter}[block]
  {\normalfont\bfseries\centering\fontsize{14}{16}\selectfont}
  {\thechapter.}
  {0.5em}
  {}
\titlespacing*{\chapter}{0pt}{-1.2cm}{1.2cm}

\titleformat{\section}
  {\normalfont\bfseries\fontsize{13}{15}\selectfont}
  {\thesection}
  {0.75em}
  {}
\titlespacing*{\section}{0pt}{1.5ex plus .5ex minus .2ex}{0.75ex}

\titleformat{\subsection}
  {\normalfont\bfseries\itshape\fontsize{12}{14}\selectfont}
  {\thesubsection}
  {0.75em}
  {}
\titlespacing*{\subsection}{0pt}{1.25ex plus .5ex minus .2ex}{0.5ex}

\titleformat{\subsubsection}
  {\normalfont\bfseries\itshape}
  {\thesubsubsection}
  {0.75em}
  {}
\titlespacing*{\subsubsection}{0pt}{1ex plus .5ex minus .2ex}{0.5ex}

\renewcommand{\cfttoctitlefont}{\hfill\bfseries\fontsize{14}{16}\selectfont}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill\bfseries\fontsize{14}{16}\selectfont}
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\cftloftitlefont}{\hfill\bfseries\fontsize{14}{16}\selectfont}
\renewcommand{\cftafterloftitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{1.5em}
\setlength{\cftbeforelottitleskip}{0pt}
\setlength{\cftafterlottitleskip}{1.5em}
\setlength{\cftbeforeloftitleskip}{0pt}
\setlength{\cftafterloftitleskip}{1.5em}
\setlength{\cftbeforechapskip}{0.2em}
\setlength{\cftbeforesecskip}{0.1em}
\setlength{\cftchapindent}{0pt}
\setlength{\cftsecindent}{1.25em}
\setlength{\cftsubsecindent}{2.5em}
\setlength{\cftchapnumwidth}{2.2em}
\setlength{\cftsecnumwidth}{2.8em}
\setlength{\cftsubsecnumwidth}{3.3em}
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftsecpagefont}{\normalfont}
\renewcommand{\cftdotsep}{1.5}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}

%%%%%%%%%%%%%%%%% Encabezados %%%%%%%%%%%%%%%%%%%%%%%
\fancypagestyle{unadefront}{
  \fancyhf{}
  \fancyhead[R]{\fontsize{10}{12}\selectfont \thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{unademain}{
  \fancyhf{}
  \fancyhead[L]{\raisebox{-4mm}[0pt][0pt]{\includegraphics[height=\UNADEHeaderLogoHeight]{\UNADE@wmfile}}}
  \fancyhead[R]{\fontsize{10}{12}\selectfont \thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{#1}}{}}
\renewcommand\p@subsubsection{\thesubsection.}


%%%%%%%%%%%%%%%%%%%%%%%%%% Definiciones de carrera %%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\@degree{\ClassWarningNoLine{tesisUNADE}{No Degree specified}}
\newcommand\degree[1]{\renewcommand\@degree{#1}}
\newcommand\thedegree{\@degree}

%%%%%%%%%%%%%%%%%%%%%%%%%% Definiciones de asesor  %%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\@advisor{\ClassWarningNoLine{tesisUNADE}{No advisor specified}}
\newcommand\advisor[1]{\renewcommand\@advisor{#1}}
\newcommand\theadvisor{\@advisor}

%%%%%%%%%%%%%%%%%%%%%%%%%% Definiciones de co-asesor (opcional) %%%%%%%%%%%%%%%%%
\let\@coadvisor\@empty                           % vacío por defecto = no se imprime
\newcommand\coadvisor[1]{\renewcommand\@coadvisor{#1}}
\newcommand\thecoadvisor{\@coadvisor}

% Etiquetas configurables (por si quieres “Directora / Codirectora”, etc.)
\newcommand{\advisorlabel}{Director}
\newcommand{\coadvisorlabel}{Codirector}
\newcommand{\setadvisorlabel}[1]{\renewcommand{\advisorlabel}{#1}}
\newcommand{\setcoadvisorlabel}[1]{\renewcommand{\coadvisorlabel}{#1}}

% Rutina para imprimir 1 o 2 líneas según exista co-asesor
\newcommand{\printadvisors}{%
  \noindent \advisorlabel: \theadvisor%
  \if\relax\detokenize\expandafter{\@coadvisor}\relax
    % nada: sólo hay un asesor
  \else
    \\[5pt]\coadvisorlabel: \thecoadvisor%
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%% Definiciones del año  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\@year{\ClassWarningNoLine{tesisUNADE}{No year specified}}
\renewcommand\year[1]{\renewcommand\@year{#1}} %Report ya tiene un comando \year
\newcommand\theyear{\@year}

%%%%%%%%%%%%%%%%%%%%%%%%%% Comandos de titulo y autor %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\thetitle{\@title}
\newcommand\theauthor{\@author}
\newcommand\thethesis{\@thesis}

% --- Student word (label) ---
\newcommand{\student}{Alumno}                 % default; you can choose "Alumno"
%\newcommand{\Student}{\MakeUppercase{\student}} % uppercase version if you need it
\newcommand{\studentlabel}{\textbf{\Student:}}  % bold label with colon (optional)

% Optional helper if you prefer a setter command:
\newcommand{\setstudent}[1]{\renewcommand{\student}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%% Portada  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\maketitle{%
  \DisableWatermark
  \InputIfFileExists{portada.tex}
    {\ClassInfo{tesisUNADE}{Loaded portada.tex}}
    {\ClassError{tesisUNADE}{No portada.tex found!}}%
  \EnableWatermark
}

%%%%%%%%%%%%%%%%%%%%%%%%%% Permisos  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\publicationrights{%
	\InputIfFileExists {derechos.tex} {\ClassInfo {tesisUNADE} {Loaded derechos.tex}} {\ClassError{tesisUNADE} {No derechos.tex found!}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%% Resumen(es) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{\@ifpackageloaded{babel}{%
	\renewenvironment{abstract}[1]{%
		\thispagestyle{empty}\bigskip%
		\begin{center}\begin{otherlanguage}{#1}\bf\abstractname\end{otherlanguage}\end{center}
	}{}
}{\ClassWarning{tesisUNADE} {Babel package was not loaded.}}}

%%%%%%%%%%%%%%%%%%%%%%%%%% Env. para citas %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{chapterquote}[2][2em]{%
	\setlength{\@tempdima}{#1}%
	\def\chapquote@author{#2}%
	\parshape 1 \@tempdima \dimexpr\textwidth-2\@tempdima\relax%
	\itshape}{\par\normalfont\hfill--\ \chapquote@author\hspace*{\@tempdima}\par\bigskip}
