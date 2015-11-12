(declare (usual-integrations))

(ns (scheme utils)
    (provide-syntax when unless if-let dlist dassoc)
    (provide list->alist constantly partial obj-get add1 sub1 assoc-default)
    (file "scheme-utils"))

#|
(import-names! 'scheme
	       'scheme-utils
	       '(list->alist constantly partial obj-get add1 sub1 assoc-default))
(import-macros! 'scheme
		'scheme-utils
		'(when unless if-let dlist dassoc))

|#


