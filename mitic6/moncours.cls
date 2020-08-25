% définition de ma classe "moncours" pour mon livre de cours TS
%
% d'après l'article de T. Colombo (GLMF n°68, fév. 2014)
% lui-même d'après la classe de M. Legrand, latextemplates.com
%
% date de création : avril 2014 --- Simon Verdan
% ceci est la version du 28 juillet 2014
%
%
%
%  TODO
%
% voir l'option fleqn de la classe book
% voir pourquoi \vspace*{} <--- conserve l'espace même en bas de page
% voir pourquoi ~\vfill
% voir l'usage de \ifthenelse{\equal{#5}{}}
%
%
\ProvidesClass{moncours}

\LoadClass[12pt,fleqn]{book}

% on règle les marges avec le package geometry
% 
\usepackage[a4paper,headsep=10pt,top=3cm,bottom=3cm,inner=3cm,outer=2cm]{geometry}
%
%
% on règle les polices de caractères (voir le site tug.dk/FontCatalogue pour le choix,
% puis téléchargement sur www.ctan.org (le .zip))
% cela donne :	cd ~/.texmf
%		wget http://mirrors.ctan.org/fonts/emerald.zip
%		unzip emerald.zip 
%		rm emerald.zip README
%		cp -R emerald/*
%		rm -R emerald
%		cd fonts/map/dvips
%		udmap --enable Map=emerald.map
%		texthash
%
%
% et les différents paramètres de langue
%
%\usepackage{microtype}		% meilleure apparence des textes ATTENTION POSE PROBLEME
\usepackage[utf8]{inputenc}	% pour avoir les accents activés
\usepackage[T1]{fontenc}	% encodage des caractères T1
\usepackage{lmodern}		% to avoid bitmapped font !
\usepackage[french]{babel}
% Je garde les polices de base, sinon on peut changer :
%\usepackage{emerald}		% police pour les titres
%\usepackage{mathptmx}		% police pour les textes

% pour les graphiques
\usepackage{graphicx}		% pour permettre l'inclusion d'image
\graphicspath{./images/}	% chemin pour les images
\usepackage{eso-pic}		% pour les images en fond de page


% packages généraux
\usepackage{ifthen}		% pour des conditions de compilations	    	
\usepackage[linktoc=all,hidelinks]{hyperref} % pour les hyperliens
% hidelinks permet de cacher les boîtes rouges autour des liens
% si version < 2012, il faut ajouter, pour cacher les boîtes rouges :
% pdfborder={0 0 0} dans les options
%
\usepackage{makeidx}            % pour générer un index
\usepackage[french]{varioref}   % pour utiliser les vref
\usepackage{colortbl}		%pour des couleurs dans les tableaux
\usepackage{multirow}		%pour les multicolonnes dans les tableaux
%\usepackage{}
%\usepackage{}

%\usepackage{draftwatermark}      % pour ajouter un filigrane sur les pages
%\SetWatermarkText{\textbf{Version professeur}}
%\SetWatermarkScale{2.5}


%
% Page de titre : 
% [#1] image de fond #2 titre #3 sous-titre #4 auteur #5 info additionnel (on peut laisser blanc si non utilisé)
%
\newcommand{\titlePage}[5][backgroundImage]{
    \begingroup
    \thispagestyle{empty}
    \AddToShipoutPicture*{\put(0,0){\includegraphics[scale=1]{#1}}  % package eso-pic nécessaire
    }
    \centering
    \vspace*{3.5cm}
    \par\fontsize{35.83}{20}	% \par pour indiquer une fin de paragraph
				% puis taille de police 40 et interligne de 20
    %\ECFAugie			% on utilise la police Augie
    %{\Huge #2}\par			% on pose le titre
    %\vspace*{0.5cm}
    %{\huge #3}\par		% le sous-titre
    %\vspace*{1cm}
    %{\LARGE #4}\par		% l'auteur
    \endgroup			% fin de la page de titre

%
% Verso de la couverture : on remet toutes les infos, dont #5 si présente
%

\begingroup
    \newpage
    ~\vfill
    \thispagestyle{empty}
    \noindent #2 -- #3\\
    \noindent #4\\
    \ifthenelse{\equal{#5}{}}{		% ici ce qu'on doit faire si test vrai
			     }
	 		     {		% ici ce qu'on doit faire si test faux
			     \noindent #5\\ 

			     \vspace{6pt}
                             
                             \includegraphics[angle=0,width=5cm]{./images/logo_flo}\\
			     %\includegraphics[angle=0,width=4cm]{./images/ccbysa} \hfill \includegraphics[angle=0,width=5cm]{./images/logo_flo}\\
			     }
    \endgroup

% 
% et rappel de la page de titre, sans l'image de fond
%

\begingroup
    \newpage
    \thispagestyle{empty}
    \centering
    \vspace*{7.5cm}
    \par\fontsize{35.83}{20}	% \par pour indiquer une fin de paragraph
				% puis taille de police 40 et interligne de 20
    %\ECFAugie			% on utilise la police Augie
    {\Huge #2}\par			% on pose le titre
    \vspace*{0.5cm}
    {\huge #3}\par		% le sous-titre
    \vspace*{1cm}
    {\LARGE #4}\par		% l'auteur
    \newpage
    \thispagestyle{empty}
    \endgroup			% fin de la page de titre




} % fin de newcommand titlePage



%
% Modification des chapitres
%
\usepackage{tikz}		% pour dessiner les figures
\usepackage{xcolor}		% permet de définir des couleurs
%\definecolor{defaultColor}{rgb}{0,0.56,1}
%\definecolor{defaultColor}{rgb}{.13,.28,.71}
% ancienne defaultColor .67,.53,.45 
\definecolor{defaultColor}{rgb}{.67,.53,.45} % brun clair
\definecolor{black}{rgb}{0,0,0}

% on créé une variable qui contient l'image de l'en-tête de chapitre
\newcommand{\theChapterImage}{}
\newcommand{\chapterImage}[1]{\renewcommand{\theChapterImage}{#1}}
% image par défaut : (c'est cette commande qu'il faut utiliser pour
% changer l'image pour un chapitre donné.
\chapterImage{./images/chapitreVinci}
%
% Explications :
%
% modification de la macro qui affiche l'en-tête du chapitre
% image à 9cm du haut de la page et à 5cm de la gauche
% un cadre arrondi d'épaisseur 2pt et tracé en bleu, un espacement de 15pt,
% et une longueur de 20cm (donc qui sort de la page)
% numéro de chapitre : \thechapter et son nom : #1
% l'esapce final de 230 pt permet de ne pas recouvrir l'image
%
\def\@makechapterhead#1{
    \thispagestyle{empty}
    {
	\begin{tikzpicture}[remember picture,overlay]
           \node at (current page.north west){
		\begin{tikzpicture}[remember picture,overlay]
		    \node[anchor=north west,inner sep=0] at (0,0){
			\includegraphics[width=\paperwidth]{\theChapterImage}
			};
			\draw[anchor=west] (5cm,-8cm) node [rounded corners=25pt,fill=white,fill opacity=.6,text opacity=1, draw=defaultColor, draw opacity=1,line width=2pt,inner sep=15pt]{
			% ici on peut préciser une police spéciale : \ECFAugie du package emerald
			\huge\textcolor{black}{\thechapter\ ---\ #1\makebox[20cm]{}
			}
		    };
		\end{tikzpicture}
	    };
	\end{tikzpicture}
    }
    \par\vspace*{200pt}
}


%
% Modification des sections
%
% Explications :
%
% \llap indique que nous nous plaçons à gauche de la marge (rlap pour la droite)
% 1em est la taille qu'occuperait un caractère
% On modifie la macro \@startsection en lui passant 6 paramètres :
% - le nom de la section (ici section) - le niveau associé pour la table des matière (1)
% - l'espace entre la marge et le titre (ici 0) - l'espace vertical qui précède le titre
% de la section - l'espace vertical qui suit le titre
% 1ex est la hauteur des plus petites lettres de la police utilisée.
%
%\renewcommand{\@seccntformat}[1]{
%    \llap{
%	\textcolor{defaultColor}{\csname the#1\endcsname}
%	\hspace{1em}
%    }
%}
%\renewcommand{\section}{
%    \@startsection{section}{1}{0pt}
%    {-4ex \@plus -1ex \@minus -.4ex}
%    {1ex \@plus.2ex }
%    {\normalfont\large\bfseries\textcolor{defaultColor}}
%}

% ici, on supprime le numéro de chapitre de la numérotation des sections
% en clair, pour la section 2 du chapitre 3, on aura 2. au lieu de 3.2.
\makeatletter
\renewcommand{\thesection}{\@arabic\c@section}
\makeatother


% T
% O
% D
% O
% ici on demande la numérotation des subsubsection au format a, b, c, etc.
%\renewcommand{\thesubsubsection}{\alph{subsubsection}}

% les en-têtes de pages
\usepackage{fancyhdr}
\pagestyle{fancy}   % on utilise le style fancy
\fancyhf{}	    % on enlève l'affichage par défaut
% style de l'en-tête
%
% Les 6 lignes ci-dessous posent problème
%
%\renewcommand{\chaptermark}[1]{
%    \markboth{\bsc{\chaptername~\thechapter{} :} #1}{}
%}
%\renewcommand{\sectionmark}[1]{
%    \markright{\thesection{} #1}
%}
%
% fin des lignes qui posent problème
%
% Pour avoir des minuscules à la place des majuscules dans les en-têtes :
%
\renewcommand{\chaptermark}[1]{\markboth{\thechapter. #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection. #1}}
%
% Définitions des en-têtes et pieds de page (even pair)
%
%\lhead[lh-even]{lh-odd} 	\lfoot[lf-even]{lf-odd}
%\chead[ch-even]{ch-odd} 	\cfoot[cf-even]{cf-odd}
%\rhead[rh-even]{rh-odd} 	\rfoot[rf-even]{rf-odd}
%
% page gauche haut (textsl pour incliné)
\lhead[\textbf{\textcolor{black}\thepage}]{
    \textsl{\rightmark}
}
% page droite haut
\rhead[\textsl{\leftmark}
	]{
    \textbf{\textcolor{black}\thepage}
}
% bas de page
\cfoot[\scriptsize{\textsl{Fiches MITIC 6\up{e}}}]{\scriptsize{\textsl{Institut Florimont}}}
%
% espacement entre l'en-tête et le corps du document (13pt par défaut)
%\setlength{\headsep}{16pt}

% largeur du trait
\renewcommand{\headrulewidth}{1pt}

% hauteur de l'en-tête
%\setlength{\headheight}{3cm}


% suppression de l'en-tête sur les pages blanches de fin de chapitre
% pour cela, la commande cleardoublepage est redéfini de telle sorte
% a effacer le contenu si la page est paire (even)
%\renewcommand{\cleardoublepage}{
%    \clearpage
%    \ifodd
%	\c@page
%    \else
%	\hbox{}
%	\vspace*{\fill}
%	\thispagestyle{empty}
%	\newpage
%    \fi
%}


% Table des matières
\usepackage{titletoc}
% on enlève les marges
\contentsmargin{0cm} % on enlève les marges par défaut
\titlecontents{chapter}[1.25cm]
{\addvspace{15pt}\large\bfseries}
{\color{black!60}\contentslabel[\Large\thecontentslabel]{1.25cm}\color{black}}
{}
% ci-dessous titlerule définit l'espacement et les caractères définissant
% les lignes qui relient le titre au numéro de page
{\color{black!60}\normalsize\bfseries \titlerule*[.5pc]{.} \thecontentspage}

% style des sections
\titlecontents{section}[1.25cm]
{\addvspace{1pt}\small}
{\contentslabel[\thecontentslabel]{1.25cm}}
{}
{\hfill\color{black}\thecontentspage}

% style des subsections
\titlecontents{subsection}[1.25cm]
{\addvspace{1pt}\scriptsize}
{\contentslabel[\thecontentslabel]{1.25cm}}
{}
{\hfill \thecontentspage}





%
% Ne marche pas donc commenté
%
%



% modification de \tableofcontents pour qu'on puisse afficher une image
% (comme pour les chapitres)
% #1 contient le nom de l'image à afficher
%\renewcommand{\tableofcontents}[1][]{
%    % en-tête gauche
%    \lhead[\textbf{\textcolor{defaultColor}\thepage}]{
%	\textsl{\contentsname}
%    }
%
%    % en-tête droite
%    \rhead[\textsl{\contentsname}]{
%	\textbf{\textcolor{defaultColor}\thepage}
%    }
%    % on initialise le num de page à 1
%    % et on change le style en roman pour la toc
%    \pagenumbering{roman}
%    \if@twocolumn
%	\@restonecoltrue\onecolumn
%    \else
%	\@restonecolfalse
%    \fi
%    \ifthenelse{\equal{#1}{}}{
%    }
%    {
%	\chapterImage{#1}
%    }
%
%    \chapter{
%	\contentsname
%	\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}
%	}
%	\@starttoc{toc}
%	\if@restonecol
%	    \twocolumn
%	\fi
%	\cleardoublepage
%	\pagestyle{fancy}
%	% on remet le num de page à 1
%	% et en style arabic
%	\pagenumbering{arabic}
%	% on réactive le header par défaut
%	\defineDefaultHeader{}
%}


%
%
% Pour changer localement les marges
% deux arguments : marge gauche, marge droite
% à utiliser \begin{changemargin}{1cm}{-2cm}
% puis \end{changemargin}
%
%
%\newenvironment{changemarges}{\begin{list}{}{%
%\setlength{\topsep}{0pt}%
%\setlength{\leftmargin}{0pt}%
%\setlength{\rightmargin}{0pt}%
%\setlength{\listparindent}{\parindent}%
%\setlength{\itemindent}{\parindent}%
%\setlength{\parsep}{0pt plus 1pt}%
%    \ifodd% si page impaire
	%\c@page
%	\addtolength{\leftmargin}{0cm}%
%	\addtolength{\rightmargin}{4cm}%
%    \else%
%	\addtolength{\leftmargin}{-4cm}%
%	\addtolength{\rightmargin}{0cm}%
%    \fi%
%} \item }{\end{list}}%
% fin de la macro



%
%
%  Des jolis boîtes
%
%


% TODO !!!


% et on ajoute les définitions d'unités et de boîtes diverses
\input{headings.tex}
