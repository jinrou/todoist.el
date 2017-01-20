;;; todoist.el --- Elisp library to interface with Todoist API -*- lexical-binding: t -*-

;; Copyright (C) 2017 Free Software Foundation, Inc.

;; Author: Kaushal Modi <kaushal.modi@gmail.com>
;; URL: https://github.com/kaushalmodi/todoist.el
;; Version: 0.0.0
;; Keywords: task management, organization

;; This file is part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Package to set and get data to/from a Todoist account using Todoist API v7
;; https://developer.todoist.com/#api-overview
;;
;; This is a library package.
;;
;; WARNING: It's safe to say that currently 0 development has happened. Stay
;; tuned as I plan to develop this as time permits.
;;
;; Plan is to use this library to develop a package that syncs org-mode TODO
;; tasks and Todoist tasks.
;;
;; NOTE TO FUTURE CONTRIBUTORS: I plan to release this package on GNU Elpa.
;; So please assign your copyright to FSF in order to get your patches
;; accepted.
;; - https://www.gnu.org/licenses/why-assign.html
;; - https://www.gnu.org/prep/maintain/html_node/Copyright-Papers.html#Copyright-Papers
;; As a bonus, once you have assigned your copyright to FSF, doors open up
;; for your contributions to Emacs and Org-Mode too!

;;; Code:

(defvar todoist-sync-api-url "https://todoist.com/API/v7/sync"
  "The same endpoint URL used by all Sync API requests.")

(defvar todoist-api-token ""
  "String containing the user's Todoist API token.")

(defvar todoist-api-token-file (locate-user-emacs-file "todoist-api-token")
  "This file should set the `todoist-api-token' variable to your Todoist API.
Example:
    (setq todoist-api-token \"<YOUR API TOKEN>\")")

(load todoist-api-token-file nil :nomessage)

(defun todoist--alist-to-cmd (alist)
  "Convert the ALIST to a shell command."
  (mapconcat 'identity alist " "))

(let* ((cmd-alist `("curl" ,todoist-sync-api-url
                    ,(concat "-d token=" todoist-api-token)
                    "-d sync_token='*'"
                    "-d resource_types='[\"all\"]'"))
       (cmd (todoist--alist-to-cmd cmd-alist)))
  (message "Todoist cmd: %s" cmd)
  (shell-command cmd "*Todoist*"))


(provide 'todoist)

;;; todoist.el ends here
