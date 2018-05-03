syn match diffComment   "^$.*"
syn match   gitcommitFirstLine	"\%^[^$].*"  nextgroup=gitcommitBlank skipnl
syn match   gitcommitBlank	"^[^$].*" contained contains=@Spell
syn match   gitcommitComment	"^$.*"
syn match   gitcommitHead	"^\%($   .*\n\)\+$$" contained transparent
syn match   gitcommitOnBranch	"\%(^$ \)\@<=On branch" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite
syn match   gitcommitOnBranch	"\%(^$ \)\@<=Your branch .\{-\} '" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite
syn match   gitcommitNoBranch	"\%(^$ \)\@<=Not currently on any branch." contained containedin=gitcommitComment
syn match   gitcommitHeader	"\%(^$ \)\@<=.*:$"	contained containedin=gitcommitComment
syn region  gitcommitAuthor	matchgroup=gitCommitHeader start=/\%(^$ \)\@<=\%(Author\|Committer\):/ end=/$/ keepend oneline contained containedin=gitcommitComment transparent
syn match   gitcommitNoChanges	"\%(^$ \)\@<=No changes$" contained containedin=gitcommitComment

syn region  gitcommitUntracked	start=/^$ Untracked files:/ end=/^$$\|^$\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUntrackedFile fold

syn region  gitcommitDiscarded	start=/^$ Change\%(s not staged for commit\|d but not updated\):/ end=/^$$\|^$\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitDiscardedType fold
syn region  gitcommitSelected	start=/^$ Changes to be committed:/ end=/^$$\|^$\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitSelectedType fold
syn region  gitcommitUnmerged	start=/^$ Unmerged paths:/ end=/^$$\|^$\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUnmergedType fold

syn match   gitcommitWarning		"\%^[^$].*: needs merge$" nextgroup=gitcommitWarning skipnl
syn match   gitcommitWarning		"^[^$].*: needs merge$" nextgroup=gitcommitWarning skipnl contained
