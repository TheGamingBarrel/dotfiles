(setq package-archives '(
                        ("elpa" . "http://tromey.com/elpa/")
                        ("gnu" . "http://elpa.gnu.org/packages/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
			("melpa" . "https://melpa.org/packages/")
                        ("melpa-stable" . "http://stable.melpa.org/packages/")))


(package-initialize)
    (require 'package)
    (menu-bar-mode -1)
    (toggle-scroll-bar -1)
    (tool-bar-mode -1)
    (require 'evil)
    (evil-mode 1)
    (linum-mode)
    (linum-relative-global-mode)
;   (global-font-lock-mode 0)
    (require 'powerline)
    (powerline-default-theme)
    (latex-preview-pane-enable)

; Line number formatting
    (setq linum-format "%d ")
    (setq-default left-fringe-width  10)
    (setq-default right-fringe-width  0)
    (set-face-attribute 'fringe nil :background "clear")


; Open current file as sudo
(defun sudo-edit (&optional arg)
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(global-set-key (kbd "C-x C-r") 'sudo-edit)

; Automatically recover windows
    (winner-mode 1) ;"C-c <left>" and "C-c <right>" undo and re-do window changes.


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (pdf-tools powerline xresources-theme writegood-mode racket-mode powershell org-link-minor-mode org-evil linum-relative latex-preview-pane exwm auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default mode-line-format
      (list
       " " mode-line-modified
       " %[" mode-line-buffer-identification "%] %l %6 "
       mode-line-misc-info
       mode-line-end-spaces))
(setq global-mode-string '((t jabber-activity-mode-string)
			  "" display-time-string appt-mode-string))
