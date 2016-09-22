;;; flycheck-swift-test.el --- Unit test for flycheck-swift. -*- lexical-binding: t -*-

;; Copyright (C) 2016 taku0

;; Authors: taku0 (http://github.com/taku0)

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Flycheck extension for Apple's Swift.

;;; Code:

(require 'flycheck-swift)

(require 'ert)
(require 'cl-lib)

(flycheck-swift-setup)

(defvar flycheck-swift-test-basedir (file-name-directory (or load-file-name buffer-file-name)))

(ert-deftest flycheck-swift-passing-correct-arguments ()
  "Test (flycheck-checker-substituted-arguments 'swift)."
  (with-temp-buffer
    (let
        ((filename (concat
                    (file-name-as-directory flycheck-swift-test-basedir)
                    "test.swift"))
         (expected-butlast
          (list
           "-extra-flag1"
           "-extra-flag2"
           "-parse"
           "-sdk" "test-sdk-path"
           "-F" "search-path-1"
           "-F" "search-path-2"
           (concat (file-name-as-directory flycheck-swift-test-basedir)
                   "linked-source.swift")
           "-target" "test-target"
           "-import-objc-header" "test-objc-header.h"
           "-Xcc" "-Iinclude-search-path-1"
           "-Xcc" "-Iinclude-search-path-2"))
         args)
      (insert-file-contents-literally filename)
      (setq buffer-file-name filename)
      (set-buffer-modified-p nil)

      (setq-local flycheck-swift-extra-flags '("-extra-flag1" "-extra-flag2"))
      (setq-local flycheck-swift-sdk-path "test-sdk-path")
      (setq-local flycheck-swift-linked-sources '("*.swift"))
      (setq-local flycheck-swift-framework-search-paths
                  '("search-path-1" "search-path-2"))
      (setq-local flycheck-swift-cc-include-search-paths
                  '("include-search-path-1" "include-search-path-2"))
      (setq-local flycheck-swift-target "test-target")
      (setq-local flycheck-swift-import-objc-header "test-objc-header.h")

      (setq args (flycheck-checker-substituted-arguments 'swift))

      (should
       (equal (file-name-nondirectory (car (last args))) "test.swift"))

      (cl-mapcar
       (lambda (actual expected)
         (should (equal actual expected)))
       (butlast args)
       expected-butlast)

      ;; to show better error message, assert on the nthcdr instead of length.
      (should (null (nthcdr (length expected-butlast) (butlast args)) )))))

(provide 'flycheck-swift-test)

;;; flycheck-swift-test.el ends here
