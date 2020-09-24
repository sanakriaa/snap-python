// snap_types.i
//
// Provides type interface between Snap.py Python and SNAP C++
//

%include typemaps.i
%apply int &OUTPUT { int& RootNIdX};
%apply int &OUTPUT { int& TreeSzX};
%apply int &OUTPUT { int& TreeDepthX};
%apply double &OUTPUT { double& EffDiamX};
%apply double &OUTPUT { double& AvgSPLX};
%apply int &OUTPUT { int& FullDiamX};
%apply int &OUTPUT { int& EdgesInX};
%apply int &OUTPUT { int& EdgesOutX};
%apply int64 &OUTPUT { int64& ClosedTriadsX};
%apply int64 &OUTPUT { int64& OpenTriadsX};
%apply int &OUTPUT { int& ClosedNTriadsX};
%apply int &OUTPUT { int& OpenNTriadsX};
%apply int &OUTPUT { int& InGroupEdgesX};
%apply int &OUTPUT { int& InOutGroupEdgesX};
%apply int &OUTPUT { int& OutGroupEdgesX};
%apply int &OUTPUT { int& ArndEdgesX};
%apply int &OUTPUT { int& InEgoEdgesX};
%apply int &OUTPUT { int& OutEgoEdgesX};

//
// TInt
//

%typemap(in) TInt& {
//%typemap(in) TInt & NId {
  //TInt I = PyInt_AsLong($input);
  //$1 = &I;
  $1 = new TInt(PyInt_AsLong($input));
}

%typemap(freearg) TInt& {
   free($1);
}

%typemap(in) const TInt& {
//%typemap(in) const TInt& value {
  //TInt I = PyInt_AsLong($input);
  //$1 = &I;
  $1 = new TInt(PyInt_AsLong($input));
}

%typemap(freearg) const TInt& {
   free($1);
}

%typemap(in) TInt {
  //TInt I = PyInt_AsLong($input);
  //$1 = I;
  $1 = TInt(PyInt_AsLong($input));
}

%typemap(in) TInt defaultValue {
  //TInt I = PyInt_AsLong($input);
  //$1 = I;
  $1 = TInt(PyInt_AsLong($input));
}

%typemap(out) TInt {
  $result = PyInt_FromLong((long) ($1.Val));
}

%typemap(out) TInt& {
  $result = PyInt_FromLong((long) ($1->Val));
}


%typecheck(SWIG_TYPECHECK_INTEGER)
   int, short, long,
   unsigned int, unsigned short, unsigned long,
   signed char, unsigned char,
   long long, unsigned long long,
   const int &, const short &, const long &,
   const unsigned int &, const unsigned short &, const unsigned long &,
   const long long &, const unsigned long long &,
   enum SWIGTYPE,
         bool, const bool &, TInt, TInt&, const TInt, const TInt&
{
  $1 = (PyInt_Check($input) || PyLong_Check($input)) ? 1 : 0;
}

//
// TFlt
//

// Translate Python floats to TFlt

%typemap(in) TFlt& {
  //TFlt F = PyFloat_AsDouble($input);
  //$1 = &F;
  $1 = new TFlt(PyFloat_AsDouble($input));
}

%typemap(freearg) TFlt& {
   free($1);
}

%typemap(in) const TFlt& {
  //TFlt F = PyFloat_AsDouble($input);
  //$1 = &F;
  $1 = new TFlt(PyFloat_AsDouble($input));
}

%typemap(freearg) const TFlt& {
   free($1);
}

%typemap(in) TFlt {
  //TFlt F = PyFloat_AsDouble($input);
  //$1 = F;
  $1 = TFlt(PyFloat_AsDouble($input));
}

%typemap(in) TFlt defaultValue {
  TFlt F = PyFloat_AsDouble($input);
  $1 = F;
  //$1 = TFlt(PyFloat_AsDouble($input));
}

%typemap(out) TFlt {
  $result = PyFloat_FromDouble((double) ($1.Val));
}

%typemap(out) TFlt& {
  $result = PyFloat_FromDouble((double) ($1->Val));
}

%typecheck(SWIG_TYPECHECK_DOUBLE)
  float, float &, const float, const float &,
  double, double &, const double, const double &,
  TFlt, TFlt &, const TFlt, const TFlt &
{
  $1 = (PyFloat_Check($input) || PyInt_Check($input) || PyLong_Check($input)) ? 1 : 0;
}

//
// TStr
//

// Translate Python strings to SNAP TStr
//%typemap(in) const TStr& attr {
//  TStr S(PyString_AsString($input));
//  $1 = &S;
//}

//%typemap(in) TStr {
  //TStr S(PyString_AsString($input));
  //$1 = &S;
//  $1 = TStr(PyString_AsString($input));
//}

%typemap(in) TStr {
  //TStr S(PyString_AsString($input));
  //$1 = &S;
  if (PyString_Check($input)) {
    $1 = TStr(PyString_AsString($input));
  } else {
    $1 = TStr(PyBytes_AS_STRING(
           PyUnicode_AsEncodedString($input, "utf-8", "Error ~")));
  }
}

//%typemap(in) TStr& {
  //TStr S(PyString_AsString($input));
  //$1 = &S;
  //$1 = new TStr(PyString_AsString($input));
//}

%typemap(in) TStr& {
  //TStr S(PyString_AsString($input));
  //$1 = &S;
  if (PyString_Check($input)) {
    $1 = new TStr(PyString_AsString($input));
  } else {
    $1 = new TStr(PyBytes_AS_STRING(
           PyUnicode_AsEncodedString($input, "utf-8", "Error ~")));
  }
}

%typemap(freearg) TStr& {
   free($1);
}

//%typemap(in) const TStr& {
  //TStr S(PyString_AsString($input));
  //$1 = &S;
  //$1 = new TStr(PyString_AsString($input));
//}

%typemap(in) const TStr& {
  //TStr S(PyString_AsString($input));
  //$1 = &S;
  if (PyString_Check($input)) {
    $1 = new TStr(PyString_AsString($input));
  } else {
    $1 = new TStr(PyBytes_AS_STRING(
           PyUnicode_AsEncodedString($input, "utf-8", "Error ~")));
  }
}

%typemap(freearg) const TStr& {
   free($1);
}

//%typemap(in) TStr defaultValue {
//  TStr S(PyString_AsString($input));
//  $1 = S;
//  //$1 = TStr(PyString_AsString($input));
//}

%typemap(in) TStr defaultValue {
  if (PyString_Check($input)) {
    TStr S(PyString_AsString($input));
    $1 = S;
  } else {
    TStr S(PyBytes_AS_STRING(
             PyUnicode_AsEncodedString($input, "utf-8", "Error ~")));
    $1 = S;
  }

  //$1 = TStr(PyString_AsString($input));
}

%typemap(out) TStr {
  $result = PyString_FromString($1.CStr());
}

%typemap(out) TStr& {
  $result = PyString_FromString($1->CStr());
}

//%typecheck(SWIG_TYPECHECK_STRING) char *, const char *, TStr, TStr&, const TStr, const TStr& {
//  $1 = PyString_Check($input) ? 1 : 0;
//}

%typecheck(SWIG_TYPECHECK_STRING) char *, const char *, TStr, TStr&, const TStr, const TStr& {
  $1 = (PyString_Check($input) || PyUnicode_Check($input)) ? 1 : 0;
}


//%typemap(in) (char *str, int len) {
//  $1 = PyString_AsString($input);   /* char *str */
//  $2 = PyString_Size($input);       /* int len   */
//}

%typemap(in) (char *str, int len) {
  if (PyString_Check($input)) {
    $1 = PyString_AsString($input);   /* char *str */
    $2 = PyString_Size($input);       /* int len   */
  } else {
    $1 = PyBytes_AS_STRING(
            PyUnicode_AsEncodedString($input, "utf-8", "Error ~"));
    $2 = PyString_Size(
            PyUnicode_AsEncodedString($input, "utf-8", "Error ~"));
  }
}

// Create type for fixed-size Python lists of doubles.
%typemap(in) double [ANY] (double temp[$1_dim0]) {
  int i;
  if (!PySequence_Check($input)) {
    PyErr_SetString(PyExc_ValueError,"Expected a sequence");
    return NULL;
  }
  if (PySequence_Length($input) != $1_dim0) {
    PyErr_SetString(PyExc_ValueError,"Size mismatch. Expected $1_dim0 elements");
    return NULL;
  }
  for (i = 0; i < $1_dim0; i++) {
    PyObject *o = PySequence_GetItem($input,i);
    if (PyNumber_Check(o)) {
      temp[i] = (double) PyFloat_AsDouble(o);
    } else {
      PyErr_SetString(PyExc_ValueError,"Sequence elements must be numbers");
      return NULL;
    }
  }
  $1 = temp;
}

// Create type for Python fixed-size lists of integers.
%typemap(in) int[ANY] (int temp[$1_dim0]) {
  int i;
  if (!PySequence_Check($input)) {
    PyErr_SetString(PyExc_ValueError,"Expected a sequence");
    return NULL;
  }
  if (PySequence_Length($input) != $1_dim0) {
    PyErr_SetString(PyExc_ValueError,"Size mismatch. Expected $1_dim0 elements");
    return NULL;
  }
  for (i = 0; i < $1_dim0; i++) {
    PyObject *o = PySequence_GetItem($input,i);
    if (PyNumber_Check(o)) {
      temp[i] = (int) PyInt_AsLong(o);
    } else {
      PyErr_SetString(PyExc_ValueError,"Sequence elements must be numbers");
      return NULL;
    }
  }
  $1 = temp;
}

// Slow but safe.  Create type for Python variable-size lists of integers (must keep argument name or create typemap.
%typemap(in) (int *arraySlow, int lengthSlow) {
  int i;
  if (!PySequence_Check($input)) {
    PyErr_SetString(PyExc_ValueError,"Expected a sequence");
    return NULL;
  }
  int lengthSlow = PySequence_Size($input);
  int *temp = (int *) malloc(lengthSlow*sizeof(int));
  for (i = 0; i < lengthSlow; i++) {
    PyObject *o = PySequence_GetItem($input,i);
    if (PyNumber_Check(o)) {
      temp[i] = (int) PyInt_AsLong(o);
    } else {
      PyErr_SetString(PyExc_ValueError,"Sequence elements must be numbers");
      return NULL;
    }
  }
  $1 = temp;
  $2 = lengthSlow;
}

// Fast.  Create type for Python variable-size lists of integers (must keep argument name or create typemap.
%typemap(in) (int *array, int length) {
  int i;
  PyObject* seq = PySequence_Fast($input, "expected a sequence");
  int length = PySequence_Size($input);
  int *temp = (int *) malloc(length*sizeof(int));
  for (i = 0; i < length; i++) {
    temp[i] = (int) PyInt_AsLong(PySequence_Fast_GET_ITEM(seq, i));
  }
  Py_DECREF(seq);
  $1 = temp;
  $2 = length;
}
%typemap(freearg) (int *array, int length) {
     if ($1) free($1);
}

// Convert an TIntV to a Python list

%module outarg

%typemap(argout) TIntV *OutValue {
  $result = PyList_New($1->Len());
  for (int i = 0; i < $1->Len(); ++i) {
    PyList_SetItem($result, i, PyInt_FromLong((*$1)[i]));
  }
  delete $1; // Avoid a leak since you called new
}

%typemap(in,numinputs=0) TIntV *OutValue(TIntV temp) {
    $1 = &temp;
}


// Rename argument example.
%typemap(in) (char *buffer, int size) = (char *str, int len);

%include "snap_types.h"

