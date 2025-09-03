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
\RequirePackage{graphicx}
\RequirePackage{amsopn}
\RequirePackage{fancyhdr}

\RequirePackage{tikz}
\RequirePackage{verbatim}

% Utilizamos babel para el manejo de idiomas
\PassOptionsToPackage{english}{babel}
\PassOptionsToPackage{spanish,es-tabla,es-nodecimaldot}{babel}
\RequirePackage{babel}

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
\renewcommand{\baselinestretch}{1.33}

%%%%%%%%%%%%%%%%% Usar numeros romanos en las subsecciones %%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\thesubsubsection{\Roman{subsubsection}}
\setcounter{secnumdepth}{3}

%%%%%%%%%%%%%%%%% Encabezados %%%%%%%%%%%%%%%%%%%%%%%
%\pagestyle{fancy}
%\lhead{}
%\rhead{\nouppercase{\textsc{\leftmark}}}
%\renewcommand{\headrulewidth}{1pt}
%\renewcommand{\footrulewidth}{1pt}
%\hrule width \hsize \kern 1mm \hrule width \hsize height 2pt 

\renewcommand{\chaptermark}[1]{\markboth{\textsc \ #1}{}}
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
\newcommand\@coadvisor{}                          % vacío por defecto = no se imprime
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
  \ifx\@coadvisor\@empty\relax
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