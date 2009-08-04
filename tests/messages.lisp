;;;; This file is part of Sheeple

;;;; tests/messages.lisp
;;;;
;;;; Unit tests for message-related stuff
;;;;
;;;; Note: Holy bejesus this entire thing blows fucking balls and needs to be
;;;;       seriously fucking cleaned up holy fuck.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package :sheeple)

(def-suite messages :in sheeple)

(def-suite message-definition :in messages)

(in-suite message-definition)

(test message-p)
(test find-message)
(test forget-all-messages)
(test forget-message)
(test finalize-message)
(test ensure-message)
(test defmessage)
(test canonize-message-option)
(test canonize-message-options)
(test check-msg-lambda-list)
(test analyze-lambda-list)

(def-suite reply-definition :in messages)
(in-suite reply-definition)

(test reply-p)
(test role-p)
(test participant-p)
(test ensure-reply)
(test generate-reply)
(test defreply)
(test create-msg-lambda-list)
(test add-reply-to-message)
(test remove-specific-reply)
(test delete-reply)
(test delete-role)
(test add-reply-to-sheeple)
(test undefine-reply)
(test remove-applicable-reply)
(test available-replies)
(test add-readers-to-sheep)
(test add-writers-to-sheep)
(test make-reply-lambda)
(test parse-defreply)
(test extract-var-name)
(test confirm-var-name)
(test undefreply)
(test parse-undefreply)

(def-suite reply-dispatch :in messages)
(in-suite reply-dispatch)

(test primary-reply-p)
(test before-reply-p)
(test after-reply-p)
(test around-reply-p)
(test apply-message)
(test apply-replies)
(test next-reply-p)
(test call-next-reply)
(test compute-effective-reply-function)
(test compute-primary-erfun)
(test find-applicable-replies)
(test %find-applicable-replies)
;; caching
(test create-reply-cache)
(test desired-vector-entry-p)
(test fetch-memo-vector-entry)
(test add-entry-to-message)
(test memoize-reply-dispatch)
;; other dispatch stuff
(test sort-applicable-replies)
(test contain-reply)
(test unbox-replies)
(test fully-specified-p)
(test calculate-rank-score)
(test reply-specialized-portion)