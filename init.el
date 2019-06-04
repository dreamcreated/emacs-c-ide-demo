(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)


(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


;; (setq company-backends (delete 'company-semantic company-backends))
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)


(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))


(require 'company-irony-c-headers)
;; Load with `irony-mode` as a grouped backend
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))


(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))




;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(company-c-headers-path-system
   (quote
    ("/usr/include/" "/usr/local/include/" "/usr/include/c++/5/")))
 '(company-c-headers-path-user
   (quote
    ("." "../util/" "../common/" "/usr/local/include/rapidjson/" "/home/tarsproto/Mod/Proto" "/home/tarsproto/PSH/Proto" "/home/tarsproto/Mod/BookResourceServer" "/home/tarsproto/Mod/QuestionBankServer" "/home/tarsproto/Mod/TeachingResourceServer" "/usr/local/tars/cpp/include" "/usr/local/mysql/include/mysql" "/usr/local/mysql/include" "/usr/include/mysql")))
 '(company-clang-arguments
   (quote
    ("-I../util/ -I../common/ -I/usr/local/include/rapidjson/ -I/home/tarsproto/Mod/Proto -I/home/tarsproto/PSH/Proto -I/home/tarsproto/Mod/BookResourceServer -I/home/tarsproto/Mod/QuestionBankServer -I/home/tarsproto/Mod/TeachingResourceServer -I/usr/local/tars/cpp/include -I./ -I/usr/local/mysql/include/mysql -I/usr/local/mysql/include -I/usr/include/mysql" "-I /usr/include/c++/5/")))
 '(custom-enabled-themes (quote (deeper-blue)))
 '(irony-additional-clang-options
   (quote
    ("-I../util/ -I../common/ -I/usr/local/include/rapidjson/ -I/home/tarsproto/Mod/Proto -I/home/tarsproto/PSH/Proto -I/home/tarsproto/Mod/BookResourceServer -I/home/tarsproto/Mod/QuestionBankServer -I/home/tarsproto/Mod/TeachingResourceServer -I/usr/local/tars/cpp/include -I./ -I/usr/local/mysql/include/mysql -I/usr/local/mysql/include -I/usr/include/mysql")))
 '(package-selected-packages
   (quote
    (auto-complete ztree vue-mode markdown-mode magit php-mode go-mode indium js2-refactor avy flycheck-irony company-irony-c-headers company-irony sr-speedbar function-args ggtags zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (require 'ggtags)
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;               (ggtags-mode 1))))

;; (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;; (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;; (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;; (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;; (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;; (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;; (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)


(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

;; (global-set-key (kbd "C-x m") 'multi-term)
(global-set-key (kbd "C-x m") 'eshell)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(global-set-key (kbd "C-c j") 'avy-goto-char)

(setq make-backup-files nil) ; stop creating backup~ files



;; 当处于最后一行时 "C-a" 将光标移动到 terminal开始处而不是这个行的头
(defun lida/is-at-end-line ()
  "判断是否在最后一行"
  (equal (line-number-at-pos) (count-lines (point-min) (point-max))))

(defun lida/is-term-mode ()
  "判断是否为 term 模式"
  (string= major-mode "term-mode"))

(defun lida/move-beginning-of-line ()
  "move begin"
  (interactive)
  (if (not (lida/is-term-mode))
      (beginning-of-line)
    (if (not (lida/is-at-end-line))
        (beginning-of-line)
      (term-send-raw))))

;; (global-set-key (kbd "C-a") 'lida/move-beginning-of-line)

(setq default-tab-width 4)
(setq indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq c-default-style "linux")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(ac-config-default)

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
