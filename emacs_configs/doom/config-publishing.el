(require 'ox-publish)


;; export settings
(setq org-export-with-section-numbers nil
      org-export-with-smart-quotes t
      org-export-with-toc nil

      org-html-preamble-format '(("en" "")))


;; Something in the magic of "org-publsh-all" triggers these components...
;; Uncertain if components MUST be listed in the "all" component.
;; Maybe this final one is the one targetted by the command?
(setq org-publish-project-alist
      '(
        ("website"
         :base-directory (format "/home/%/org-files/website/" user-login-name)
         :base-extension "org"
         :publishing-directory "/mnt/nfs/joshua-neely.com/core_public/"
         :recursive t
         :auto-sitemap nil
         :author "Joshua Neely"
         :email "joshua.a.neely@gmail.com"
         :with-creator t
         :publishing-function org-html-publish-to-html)

        ;; org-html-publish-to-html transforms inputs as it copies them over.
        ;; It generates html from org, like you'd expect
        ("posts"
         :base-directory (format "/home/%/org-files/" user-login-name)
         :base-extension "org"
         :publishing-directory "/mnt/nfs/joshua-neely.com/blog_public/"
         :recursive t
         :auto-sitemap nil
         :author "Joshua Neely"
         :email "joshua.a.neely@gmail.com"
         :with-creator t
         :publishing-function org-html-publish-to-html)

        ;; using "org-publish-attachment" simply copies the files to the destination
        ;; this is good for css, js, and images
        ("css-website"
         :base-directory (format "/home/%/org-files/website/css/" user-login-name)
         :base-extension "css"
         :publishing-directory "/mnt/nfs/joshua-neely.com/core_public/css/"
         :recursive t
         :publishing-function org-publish-attachment)

        ("css-blog"
         :base-directory (format "/home/%/org-files/css/" user-login-name)
         :base-extension "css"
         :publishing-directory "/mnt/nfs/joshua-neely.com/blog_public/css/"
         :recursive t
         :publishing-function org-publish-attachment)

        ("images"
         :base-directory (format "/home/%/org-files/images/" user-login-name)
         :base-extension "png\\|jpg\\|gif\\|pdf"
         :publishing-directory "/mnt/nfs/joshua-neely.com/blog_public/images/"
         :recursive t
         :publishing-function org-publish-attachment)
        ))


;; custom search function.
;; For my usecase, I should somehow limit the search to some subsection of the file.
;; For example, the first 10 lines.
(defun search-file-for-text-match (file-path find-string)
  "Return the input file-path if find-string is found within, else nil"
  (let (myBuffer p1 p2 (foundCount 0))

    (with-temp-buffer
      (insert-file-contents file-path nil nil nil t)

      (goto-char 1)
      (while (search-forward find-string nil t)
        (setq foundCount (1+ foundCount)))

      ;; report if the occurrence is not n times
      (when (not (= foundCount 0))
        file-path))))


(defun is-blog-file-ready-for-publish (file-path)
  (setq blog-publish-tag "#+BLOG_PUBLISH: t")
  (setq website-publish-tag "#+WEBSITE_PUBLISH: t")
  (setq generic-publish-tag "#+PUBLISH: t")
  (or (search-file-for-text-match file-path blog-publish-tag)
      (search-file-for-text-match file-path website-publish-tag)
      (search-file-for-text-match file-path generic-publish-tag)
   ))


;; unused... doesn't appear to work?
(defun publish-every-marked-blog-file ()
  "Search the org directory for files marked with the blog-publish tag and publish those files"
  (interactive)

  (setq input-dir (format "/home/%/org-files/" user-login-name) )

  (setq all-org-files
        (directory-files-recursively input-dir "\.org$" ))
  (setq matched-files
        (remove nil (mapcar 'is-blog-file-ready-for-publish all-org-files)))
  (mapc 'org-publish-file matched-files)
  (format "Publishing the following files %s" matched-files))


(defun publish-blog-file-if-marked (file-path)
  (if (is-blog-file-ready-for-publish file-path)
      (progn
        (org-publish-file file-path)
        (concat file-path "  was published"))
      (concat file-path "  did not publish")))


;; buffer-file-name is the currently opened file
(defun publish-current-file-if-marked ()
  (publish-blog-file-if-marked (buffer-file-name)))


(defun build-sitemap ()
  "Search the org directory for files marked with the blog-publish tag and build a sitemap with links to those files"
  (interactive)
  (setq input-dir (format "/home/%/org-files/" user-login-name) )
  (setq index-file-name "index.org" )

  ;; clear publish cache
  (org-publish-remove-all-timestamps)

  (setq all-org-files
        (directory-files-recursively input-dir "\.org$" ))
  (setq matched-files
         (remove nil (mapcar 'is-blog-file-ready-for-publish all-org-files)))

  (with-temp-file (concat input-dir index-file-name)
    (insert (concat
             "#+TITLE: Blog Index\n"
             "#+BLOG_PUBLISH: t\n"
             "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"css/basic.css\" />\n"
             "#+HTML_DOCTYPE: html5\n"
             ))
    (defun insert-match-into-file (match-file-name)
      ;;(if (not t)
      (if (not (equal match-file-name index-file-name))
          (insert (format "- [[file:%s]]\n" match-file-name))
        nil
        )
      )
    (mapc 'insert-match-into-file matched-files))

  (org-publish-file (format "/home/%/org-files/index.org" user-login-name)))


(defun publish-css ()
  (interactive)
  (org-publish-project "css" t))

(defun publish-images ()
  (interactive)
  (org-publish-project "images" t))

(defun publish-sitemap () (build-sitemap))


(add-hook 'css-mode-hook
          (lambda () (add-hook 'after-save-hook 'publish-css :append :local)
                     (add-hook 'after-save-hook 'publish-images :append :local)
                     ))

(add-hook 'org-mode-hook
          (lambda () (add-hook 'after-save-hook 'publish-current-file-if-marked :append :local)))


;; customize the footer on published html files
;; tell the postable to use the specified format (instead of generating one from other variables- see 'auto)
(setq org-html-postamble t)
;; define the postable  format
(setq org-html-postamble-format
  '(("en" "<p class=\"author\">Author: %a  (%e)</p>
<p class=\"date\">Last Modified: %C</p>
<p class=\"creator\">%c</p>")))
