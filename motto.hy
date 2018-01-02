(import [trytond.model [ModelSQL ModelView fields]])
(import [trytond.pyson [If Eval]])
(import [trytond.transaction [Transaction]])
(def --all-- ["Motto"])

(defclass Motto [ModelSQL ModelView]
  "Motto Company"
  [--name-- "motto"
   name (.Char fields "Name" :required True)
   company (.Many2One fields "company.company" "Company"
                      :required True
                      :select True   ;; we know queries will be done by company
                      :domain
                      [(, "id"
                        (If (.contains
                              (Eval "context" {})
                              "company")
                            "=" "!=")
                        (.get (Eval "context" {}) "company" -1)
                                        )
                       ])]

  (with-decorator staticmethod
    (defn default-company []
      (.get (. (Transaction) context) "company"))
    )
  )
