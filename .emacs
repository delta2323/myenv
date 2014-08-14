(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8) 

(show-paren-mode t)
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/haskell-mode/")

(require 'flymake)

(load "haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; google-c-style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; 日本語ロケールではerrorとwarningが区別できないのでmake実行時は英語ロケールで
(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s"
              "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
              "SYNTAX_CHECK_MODE=1"
              "LANG=C"
              "check-syntax")))

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))

(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "gray40")

;; Control + すべてのキー　を無視する
(if window-system (progn

  ;; 文字の色を設定します。
  (add-to-list 'default-frame-alist '(foreground-color . "white"))
  ;; 背景色を設定します。
  (add-to-list 'default-frame-alist '(background-color . "black"))
  ;; カーソルの色を設定します。
;  (add-to-list 'default-frame-alist '(cursor-color . "SlateBlue2"))
  ;; マウスポインタの色を設定します。
 ; (add-to-list 'default-frame-alist '(mouse-color . "SlateBlue2"))
  ;; モードラインの文字の色を設定します。
  ;(set-face-foreground 'modeline "white")
  ;; モードラインの背景色を設定します。
;  (set-face-background 'modeline "MediumPurple2")
  ;; 選択中のリージョンの色を設定します。
;  (set-face-background 'region "LightSteelBlue1")
  ;; モードライン（アクティブでないバッファ）の文字色を設定します。
;  (set-face-foreground 'mode-line-inactive "gray30")
  ;; モードライン（アクティブでないバッファ）の背景色を設定します。
;  (set-face-background 'mode-line-inactive "gray85")

))

(global-set-key "\C-h" 'delete-backward-char)

;(require 'linum)
;(global-linum-mode)
;(custom-set-variables)
;(custom-set-faces)



(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

(require 'ruby-mode)
;loads ruby mode when a .rb file is opened.
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))

(put 'set-goal-column 'disabled nil)

;;;;  flymake for ruby
(require 'flymake)
;; I don't like the default colors :)
(set-face-background 'flymake-errline "red1")
(set-face-background 'flymake-warnline "dark slate blue")
;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)


(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (not (null buffer-file-name)) (flymake-mode))))


;; Macaulay 2 start
(load ".emacs-Macaulay2" t)
;; Macaulay 2 end

(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/")
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(require 'go-mode)
(add-to-list 'exec-path (expand-file-name "/usr/local/go/bin"))
(add-to-list 'exec-path (expand-file-name "~/golang/bin"))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

