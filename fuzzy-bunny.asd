(defsystem "fuzzy-bunny"
  :version "0.1.0"
  :author "Stewart V. Wright"
  :license "MIT"
  :components ((:module "src"
                :components
                ((:file "main")))
               (:module "src/gbbopen"
                :components
                ((:file "misc")
                 (:file "double-metaphone" :depends-on ("misc")))))
  :description "A collection of metrics and phonetic (fuzzy) string matching algorithms"
  :in-order-to ((test-op (test-op "fuzzy-bunny/tests"))))


;; (defsystem "fuzzy-bunny/tests"
;;   :author "Stewart V. Wright"
;;   :license "MIT"
;;   :depends-on ("fuzzy-bunny"
;;                "rove")
;;   :components ((:module "tests"
;;                 :components
;;                 ;; ((:file "main-api")
;;                 ))
;;   :description "Test system for fuzzy-bunny"
;;   :perform (test-op (op c) (symbol-call :rove :run c)))
