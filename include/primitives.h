/* Lispc - primitive procedures */

Value* apply_arithmetic_primitive(List*, int);
void append_primitive_procedure(List*, char*, int num_args, Value* (*) (List*));
