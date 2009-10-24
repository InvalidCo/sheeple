;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;;
;;;; This file is part of Sheeple

;;;; tests/reply-definition.lisp
;;;;
;;;; Unit tests for reply-definition and replies
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package :sheeple)

(def-suite reply-definition :in messages)

(def-suite reply-objects :in reply-definition)
(in-suite reply-objects)

(defun %%make-reply (&key message qualifiers lambda-list function)
  (make-reply message qualifiers lambda-list function))

(test make-reply
  (let ((test-reply (make-reply nil 1 2 3)))
    (is (replyp test-reply))
    (is (eq 'reply (type-of test-reply)))
    (is (null (reply-message     test-reply)))
    (is (= 1 (reply-qualifiers  test-reply)))
    (is (= 2 (reply-lambda-list test-reply)))
    (is (= 3 (reply-function    test-reply)))))

(test reply-name
  (let* ((message (%make-message :name (gensym)))
         (reply   (make-reply message 1 2 3)))
    (is (eq (message-name message) (reply-name reply)))))

(def-suite role-objects :in reply-definition)
(in-suite role-objects)

(test role-implementation
  (for-all ((dummy-reply (gen-integer)) (dummy-position (gen-integer)))
    (let ((role (make-role dummy-reply dummy-position)))
      (is (eq dummy-reply (role-reply role)))
      (is (eq dummy-position (role-position role))))))

(test role-type
  (for-all ((reply (fun (make-reply nil 1 2 3))) (position (gen-integer)))
    (is (typep (make-role reply position) 'role))
    (is (rolep (make-role reply position)))))

(test role-message
  (for-all ((message (fun (%make-message))))
    (is (eq message (role-message (make-role (make-reply message 1 2 3) 0))))))

(test role-name
  (for-all ((message (fun (%make-message :name (gensym)))))
    (is (eq (message-name message) (role-name (make-role (make-reply message 1 2 3) 0))))))

(test participantp
  (for-all ((object (fun (std-allocate-object =standard-metaobject=)))
            (reply (fun (make-reply nil 1 2 3))) (position (gen-integer)))
    (push (make-role reply position) (%object-roles object))
    (is (not (null (participantp object reply))))))

(in-suite reply-definition)

(test ensure-reply)

(test reply-redefinition
  (unwind-protect
       (progn (defmessage foo (bar))
              (defreply foo ((bar =t=)) 1)
              (is (= 1 (funcall 'foo 'x)))
              (defreply foo ((bar =t=)) 2)
              (is (= 2 (funcall 'foo 'x))))
    (undefmessage foo)))

(test add-reply-to-message)
(test add-reply-to-objects)
(test available-replies)
(test add-reader-to-object)
(test add-readers-to-object)
(test add-writer-to-object)
(test add-writers-to-object)

(def-suite reply-undefinition :in reply-definition)
(in-suite reply-undefinition)

(test undefine-reply)
(test remove-specific-reply)
(test remove-applicable-reply)
(test delete-reply)
(test delete-role)

(def-suite user-interface :in reply-definition)
(in-suite user-interface)

(test defreply)
(test %defreply-expander)
(test make-reply-lambda)
(test parse-defreply)
(test extract-var-name)
(test confirm-var-name)
(test undefreply
  (unwind-protect
       (let ((object (object)) warned)
         (handler-bind
             ((automatic-message-creation (fun
                                            (pass "Warned correctly.")
                                            (setf warned t)
                                            (muffle-warning _))))
           (defreply test-message ((x object)) x))
         (unless warned (fail "Didn't warn for automatic message creation."))
         (is (not (null (undefreply test-message (object)))))
         (signals no-applicable-replies (funcall 'test-message object))
         (is (null (undefreply test-message (object))))
         (is (null (%object-roles object))))
    (undefine-message 'test-message)))
(test parse-undefreply)
