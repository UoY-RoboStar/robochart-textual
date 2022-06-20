package circus.robocalc.robochart.textual

import circus.robocalc.robochart.And
import circus.robocalc.robochart.AnyType
import circus.robocalc.robochart.ArrayAssignable
import circus.robocalc.robochart.ArrayExp
import circus.robocalc.robochart.AsExp
import circus.robocalc.robochart.Assignable
import circus.robocalc.robochart.BooleanExp
import circus.robocalc.robochart.CallExp
import circus.robocalc.robochart.Cat
import circus.robocalc.robochart.ClockExp
import circus.robocalc.robochart.Declaration
import circus.robocalc.robochart.DefiniteDescription
import circus.robocalc.robochart.Different
import circus.robocalc.robochart.Div
import circus.robocalc.robochart.ElseExp
import circus.robocalc.robochart.EnumExp
import circus.robocalc.robochart.Enumeration
import circus.robocalc.robochart.Equals
import circus.robocalc.robochart.Exists
import circus.robocalc.robochart.Expression
import circus.robocalc.robochart.FloatExp
import circus.robocalc.robochart.Forall
import circus.robocalc.robochart.Function
import circus.robocalc.robochart.FunctionType
import circus.robocalc.robochart.GreaterOrEqual
import circus.robocalc.robochart.GreaterThan
import circus.robocalc.robochart.IfExpression
import circus.robocalc.robochart.Iff
import circus.robocalc.robochart.Implies
import circus.robocalc.robochart.InExp
import circus.robocalc.robochart.IntegerExp
import circus.robocalc.robochart.InverseExp
import circus.robocalc.robochart.IsExp
import circus.robocalc.robochart.LambdaExp
import circus.robocalc.robochart.LessOrEqual
import circus.robocalc.robochart.LessThan
import circus.robocalc.robochart.LetExpression
import circus.robocalc.robochart.Literal
import circus.robocalc.robochart.MatrixExp
import circus.robocalc.robochart.MatrixType
import circus.robocalc.robochart.Minus
import circus.robocalc.robochart.Modulus
import circus.robocalc.robochart.Mult
import circus.robocalc.robochart.Neg
import circus.robocalc.robochart.Not
import circus.robocalc.robochart.Or
import circus.robocalc.robochart.ParExp
import circus.robocalc.robochart.Plus
import circus.robocalc.robochart.PrimitiveType
import circus.robocalc.robochart.ProductType
import circus.robocalc.robochart.RangeExp
import circus.robocalc.robochart.RecordExp
import circus.robocalc.robochart.RefExp
import circus.robocalc.robochart.RelationType
import circus.robocalc.robochart.ResultExp
import circus.robocalc.robochart.RoboChartFactory
import circus.robocalc.robochart.Selection
import circus.robocalc.robochart.SeqExp
import circus.robocalc.robochart.SeqType
import circus.robocalc.robochart.SetComp
import circus.robocalc.robochart.SetExp
import circus.robocalc.robochart.SetRange
import circus.robocalc.robochart.SetType
import circus.robocalc.robochart.StateClockExp
import circus.robocalc.robochart.StringExp
import circus.robocalc.robochart.TransposeExp
import circus.robocalc.robochart.TupleExp
import circus.robocalc.robochart.Type
import circus.robocalc.robochart.TypeDecl
import circus.robocalc.robochart.TypeExp
import circus.robocalc.robochart.TypeRef
import circus.robocalc.robochart.VarExp
import circus.robocalc.robochart.VarRef
import circus.robocalc.robochart.VarSelection
import circus.robocalc.robochart.Variable
import circus.robocalc.robochart.VariableModifier
import circus.robocalc.robochart.VectorExp
import circus.robocalc.robochart.VectorType
import java.util.HashMap
import java.util.Map
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.EcoreUtil2

class RoboCalcTypeProvider {
	var TypeRef booleanType = null
	var TypeRef intType = null
	var TypeRef natType = null
	var TypeRef stringType = null
	var TypeRef realType = null

	def Type getBooleanType(EObject e) {
		if (e.eResource !== null) getBooleanType(e.eResource.resourceSet)
		else booleanType
	}

	def Type getBooleanType(ResourceSet rs) {
		if (booleanType === null) {
			val types = rs.allContents.filter(PrimitiveType).filter[t|t.name.equals("boolean")].toList
			if (types.size === 0) {
				throw new Error("No boolean type found")
			}
			booleanType = RoboChartFactory.eINSTANCE.createTypeRef()
			var bool = types.get(0)
			booleanType.ref = bool
		}
		booleanType
	}

	def Type getRealType(EObject e) {
		if (e.eResource !== null) getRealType(e.eResource.resourceSet)
		else realType
	}

	def Type getRealType(ResourceSet rs) {
		if (realType === null) {
			val types = rs.allContents.filter(PrimitiveType).filter[t|t.name.equals("real")].toList
			if (types.size === 0) {
				throw new Error("No real type found")
			}
			realType = RoboChartFactory.eINSTANCE.createTypeRef()
			var t = types.get(0)
			realType.ref = t
		}
		realType
	}

	def Type getIntType(EObject e) {
		if (e.eResource !== null) getIntType(e.eResource.resourceSet)
		else intType
	}

	def Type getIntType(ResourceSet rs) {
		if (intType === null) {
			val types = rs.allContents.filter(PrimitiveType).filter[t|t.name.equals("int")].toList
			if (types.size === 0) {
				throw new Error("No int type found")
			}
			intType = RoboChartFactory.eINSTANCE.createTypeRef()
			var bool = types.get(0)
			intType.ref = bool
		}
		intType
	}

	def Type getNatType(EObject e) {
		if (e.eResource !== null)
			getNatType(e.eResource.resourceSet)
		else natType
	}

	def Type getNatType(ResourceSet rs) {
		if (natType === null) {
			val types = rs.allContents.filter(PrimitiveType).filter[t|t.name.equals("nat")].toList
			if (types.size === 0) {
				throw new RuntimeException("No nat type found")
			}
			natType = RoboChartFactory.eINSTANCE.createTypeRef()
			var bool = types.get(0)
			natType.ref = bool
		}
		natType
	}

	def Type getStringType(EObject e) {
		if (e.eResource !== null) getStringType(e.eResource.resourceSet)
		else stringType
	}

	def Type getStringType(ResourceSet rs) {
		if (stringType === null) {
			val types = rs.allContents.filter(PrimitiveType).filter[t|t.name.equals("string")].toList
			if (types.size === 0) {
				throw new Error("No nat type found")
			}
			stringType = RoboChartFactory.eINSTANCE.createTypeRef()
			var bool = types.get(0)
			stringType.ref = bool
		}
		stringType
	}

	def instantiateTypes(EObject o) {
		getBooleanType(o);
		getIntType(o);
		getNatType(o);
		getStringType(o);
		getRealType(o);
	}

	def Type typeFor(EObject o, ResourceSet rs) {
		getBooleanType(rs);
		getIntType(rs);
		getNatType(rs);
		getStringType(rs);
		getRealType(rs);
		typeFor(o);
	}

	def dispatch Type typeFor(Declaration e) {
		return e.value?.typeFor
	}

	def dispatch Type typeFor(ArrayExp e) {
		// I'll make it work for A[1], need to fix it to work for A[1][2] etc
		val se = e.value
		if(se === null) return null
		val t = se.typeFor
		if(t === null) return null
		for (i : e.parameters) {
			val ti = i.typeFor
			val integer = getIntType(e)
			if(!typeCompatible(ti, integer)) return null
		}
		if (t instanceof SeqType) {
			return normalise(t.domain)
		} else if (t instanceof ProductType && e.parameters.size === 1 && e.parameters.get(0) instanceof IntegerExp) {
			val index = (e.parameters.get(0) as IntegerExp).value
			if (index > 0 && index <= (t as ProductType).types.size) {
				return normalise((t as ProductType).types.get(index - 1))
			} else
				return null
		} else if (t instanceof VectorType && e.parameters.size === 1) {
			// cannot check if indices are within range unless they are IntegerExp.
			return normalise((t as VectorType).base)
		} else if (t instanceof MatrixType && e.parameters.size === 2) {
			// cannot check if indices are within range unless they are IntegerExp.
			return normalise((t as MatrixType).base)
		}
		else if (t instanceof TypeRef && (t as TypeRef).ref instanceof Literal) {
			val variant = ((t as TypeRef).ref) as Literal // a variant is interpreted as a constructor function
			val index = (e.parameters.get(0) as IntegerExp).value
			if (index > 0 && index <= variant.types.size) {
				return normalise(variant.types.get(index - 1))
			} else
				return null
		}

		return null
	}

	def dispatch Type typeFor(ArrayAssignable e) {
		// I'll make it work for A[1], need to fix it to work for A[1][2] etc
		val se = e.value
		if(se === null) return null
		val t = se.typeFor
		if(t === null) return null
		for (i : e.parameters) {
			val ti = i.typeFor
			val integer = getIntType(e)
			if(!typeCompatible(ti, integer)) return null
		}
		if (t instanceof SeqType) {
			return normalise(t.domain)
		}

		return null
	}

	def dispatch Type typeFor(VarExp e) {
		normalise(e.value?.type)
	}

	def dispatch Type typeFor(Selection e) {
		normalise(e.member?.type)
	}

	def dispatch Type typeFor(Assignable e) {
		switch (e) {
			VarRef: if (e.name instanceof Variable) normalise((e.name as Variable).type)
			VarSelection: normalise(e.member?.type)
		}
	}

	def dispatch Type typeFor(SetExp e) {
		val t = RoboChartFactory.eINSTANCE.createSetType
		if (e.values.size() === 0) {
			t.domain = RoboChartFactory.eINSTANCE.createAnyType
		} else {
			var t1 = e.values.get(0).typeFor
			for (var i = 1; i < e.values.size; i++) {
				val aux = e.values.get(i).typeFor
				if(typeCompatible(t1, aux)) t1 = aux else if(!typeCompatible(aux, t1)) return null
			}

			t.domain = EcoreUtil2.copy(t1)
		}
		return normalise(t)
	}

	def dispatch Type typeFor(SetComp e) {
		val t = RoboChartFactory.eINSTANCE.createSetType
		if (e.expression !== null) {
			t.domain = EcoreUtil2.copy(e.expression.typeFor)	
		} else {
			val tuple = RoboChartFactory.eINSTANCE.createProductType
			if (e.variables.size == 1) {
				t.domain = EcoreUtil2.copy(e.variables.get(0).type)
			} else if (e.variables.size > 1) {
				for (v: e.variables) {
					tuple.types.add(EcoreUtil2.copy(v.type))
				}
				t.domain = tuple	
			} else {
				return null
			}
		}
		return normalise(t)
	}

	def dispatch Type typeFor(SeqExp e) {
		val t = RoboChartFactory.eINSTANCE.createSeqType
		if (e.values.size() === 0) {
			t.domain = RoboChartFactory.eINSTANCE.createAnyType
		} else {
			var t1 = e.values.get(0).typeFor
			for (var i = 1; i < e.values.size; i++) {
				val aux = e.values.get(i).typeFor
				if(typeCompatible(t1, aux)) t1 = aux else if(!typeCompatible(aux, t1)) return null
			}
			t.domain = EcoreUtil2.copy(t1)
		}
		return normalise(t)
	}
	
	def dispatch Type typeFor(EnumExp e) {
		val t = RoboChartFactory.eINSTANCE.createTypeRef()
		t.ref = e.type
		t
	}
	
	def dispatch Type typeFor(RecordExp e) {
		val t = RoboChartFactory.eINSTANCE.createTypeRef()
		t.ref = e.record
		return t
	}

	def dispatch Type typeFor(RefExp e) {
		val r = e.ref
		switch (r) {
			Variable:
				return normalise(r.type)
			Literal: {
				val t = RoboChartFactory.eINSTANCE.createTypeRef()
				t.ref = (r.eContainer as Enumeration)
				// t.ref = r.type
				return normalise(t)
			}
			Declaration: {
				r.value.typeFor
			}
			Function: {
				val t = RoboChartFactory.eINSTANCE.createFunctionType()
				var Type domain = null
				if (r.parameters.size >= 1) {
					domain = RoboChartFactory.eINSTANCE.createProductType()
					for (x : r.parameters) {
						if(x.type === null) return null;
						(domain as ProductType).types.add(EcoreUtil2.copy(x.type))
					}
				} 
				// Removing this case to distinguish f(x:nat,y:nat) from f(x:nat*nat) 
//				else if (r.parameters.size === 1) {
//					domain = EcoreUtil2.copy(r.parameters.get(0).type)
//				} 
				else
					return normalise(r.type)
				val range = EcoreUtil2.copy(r.type)
				t.domain = domain
				t.range = range
				return normalise(t)
			}
		}
	}

	def dispatch Type typeFor(CallExp e) {
//		if (e.function instanceof Function) {
//			val f = e.function as Function
//			if (f.parameters.size !== e.args.size) return null
//			for (var i = 0; i < f.parameters.size; i++) {
//				val t1 = e.args.get(i).typeFor
//				val t2 = f.parameters.get(i).type
//				if (!typeCompatible(t1,t2)) return null
//			}
//			return f.type
//		} else 
		if (e.function instanceof Expression) {
			val t = e.function.typeFor
			if (t instanceof FunctionType) {
				if (t.domain instanceof ProductType) {
					val p = t.domain as ProductType
					if(p.types.size !== e.args.size) return null
					val argstype = RoboChartFactory.eINSTANCE.createProductType()
					for (var i = 0; i < p.types.size; i++) {
						val t1 = e.args.get(i).typeFor
						if(t1 === null) return null
						argstype.types.add(EcoreUtil2.copy(t1))
						val t2 = p.types.get(i)
						if(!typeCompatible(t1, t2)) return null
					}
					val u = unify(t.domain, argstype)
					val nt = instantiate(t.range, u)
					return nt
				} else if (e.args.size === 1) {
					val t1 = e.args.get(0).typeFor
					val t2 = t.domain
					if (!typeCompatible(t1, t2))
						return null
					else {
						val u = unify(t1, t2)
						val nt = instantiate(t.range, u)
						return nt
					}
				} else {
					return null
				}
			}
			else if (t instanceof TypeRef && (t as TypeRef).ref instanceof Literal) {
				val variant = (t as TypeRef).ref as Literal // a variant is interpreted as a constructor function
				if (variant.types.size !== e.args.size) return null; // wrong number of parameters
				for (var i = 0; i < variant.types.size; i++) {
					var type = variant.types.get(i)
					var exp_type = e.args.get(i).typeFor
					if (exp_type === null) return null // one of the parameters cannot be typed
					if (!typeCompatible(exp_type,type)) return null // one of the parameters has the wrong type
				}
				// I'm not dealing with generic enumerations, so I think unification is not necessary here.
				// It may be needed in future.
				val typeref = RoboChartFactory.eINSTANCE.createTypeRef();
				typeref.ref = EcoreUtil2.copy(variant);
				return normalise(typeref);
			}
//			else if (t instanceof TypeRef && (t as TypeRef).ref instanceof Enumeration) {
//				val variant = (e.function as RefExp).ref as Constant // a variant is interpreted as a constructor function
//				if (variant.types.size !== e.args.size) return null; // wrong number of parameters
//				for (var i = 0; i < variant.types.size; i++) {
//					var type = variant.types.get(i)
//					var exp_type = e.args.get(i).typeFor
//					if (exp_type === null) return null // one of the parameters cannot be typed
//					if (!typeCompatible(exp_type,type)) return null // one of the parameters has the wrong type
//				}
//				// I'm not dealing with generic enumerations, so I think unification is not necessary here.
//				// It may be needed in future.
//				val typeref = RoboChartFactory.eINSTANCE.createTypeRef();
//				typeref.ref = EcoreUtil2.copy(variant);
//				return typeref;
//			}
			else
				return normalise(t)
		}
//		 else if (e.function instanceof Variable) {
//			val t = (e.function as Variable).type
//			if (t instanceof FunctionType) {
//				if (t.domain instanceof ProductType) {
//					val p = t.domain as ProductType
//					if (p.types.size !== e.args.size) return null
//					for (var i = 0; i < p.types.size; i++) {
//						val t1 = e.args.get(i).typeFor
//						val t2 = p.types.get(i)
//						if (!typeCompatible(t1,t2)) return null
//					}
//					return t.range
//				} else if (e.args.size === 1) {
//					val t1 = e.args.get(0).typeFor
//					val t2 = t.domain
//					if (!typeCompatible(t1,t2)) return null
//					else return t.range
//				} else return null
//			} else return null
//		}
	}

	def dispatch Type typeFor(Equals e) {
		val b = getBooleanType(e)
		val t1 = e.left.typeFor
		val t2 = e.right.typeFor
		// not sure if this is this is needed. If type compatibility is commutative, than it is not needed
		if(!typeCompatible(t1, t2) && !(typeCompatible(t2, t1))) return null else return normalise(b)
	}

	def dispatch Type typeFor(Iff e) {
		val b = getBooleanType(e)
		val t1 = e.left.typeFor
		val t2 = e.right.typeFor
		if(!typeCompatible(t1, b) || !(typeCompatible(t2, b))) return null else return normalise(b)
	}

	def dispatch Type typeFor(Implies e) {
		val b = getBooleanType(e)
		val t1 = e.left.typeFor
		val t2 = e.right.typeFor
		if(!typeCompatible(t1, b) || !(typeCompatible(t2, b))) return null else return normalise(b)
	}

	def dispatch Type typeFor(And e) {
		val b = getBooleanType(e)
		val t1 = e.left.typeFor
		val t2 = e.right.typeFor
		if(!typeCompatible(t1, b) || !(typeCompatible(t2, b))) return null else return normalise(b)
	}

	def dispatch Type typeFor(Or e) {
		val b = getBooleanType(e)
		val t1 = e.left.typeFor
		val t2 = e.right.typeFor
		if(!typeCompatible(t1, b) || !(typeCompatible(t2, b))) return null else return normalise(b)
	}

	def dispatch Type typeFor(Not e) {
		val b = getBooleanType(e)
		val t1 = e.exp.typeFor
		if(!typeCompatible(t1, b)) return null else return normalise(b)
	}

	def dispatch Type typeFor(ParExp e) {
		return e.exp.typeFor
	}
	
	def Type commonType(Type t1, Type t2) {
		val nat = getNatType(t1)
		val integer = getIntType(t1)
		val real = getRealType(t1)
		if (typeCompatible(t1, nat) && typeCompatible(t2, nat))
			return nat
		else if (typeCompatible(t1, integer) && typeCompatible(t2, integer))
			return integer
		else if(typeCompatible(t1, real) && typeCompatible(t2, real)) 
			return real
	}
	
	def boolean equalsConstExp(Expression e1, Expression e2) {
		if (e1 instanceof RefExp && e2 instanceof RefExp) {
			val r1 = (e1 as RefExp).ref
			val r2 = (e2 as RefExp).ref
			if (r1 instanceof Variable && r2 instanceof Variable) {
				val v1 = (r1 as Variable)
				val v2 = (r2 as Variable)
				if (v1.modifier == VariableModifier.CONST && v2.modifier == VariableModifier.CONST) {
					// I'm only equating constats with the same name. Otherwise, we need to have a way of evaluating expressions
					// over constants even if they are undefined.
					return v1.equals(v2)
				} else return false
			} else return false
		} else if (e1 instanceof IntegerExp && e2 instanceof IntegerExp) {
			return (e1 as IntegerExp).value == (e2 as IntegerExp).value
		} else return false
	}
	
	def dispatch Type typeFor(VectorExp e) {
		var base = EcoreUtil2.copy(e.values.get(0).typeFor)
		for (var i = 1; i < e.values.size; i++) {
			val other = EcoreUtil2.copy(e.values.get(i).typeFor)
			if (!typeCompatible(base,other) && !typeCompatible(other,base)) {
				return null
			} else {
				base = commonType(base,other)
			}
		}
		val t = RoboChartFactory.eINSTANCE.createVectorType()
		t.base = base
		val n = RoboChartFactory.eINSTANCE.createIntegerExp()
		n.value = e.values.size
		t.size = n
		return t
	}
	
	def dispatch Type typeFor(MatrixExp e) {
		var vt = EcoreUtil2.copy(e.values.get(0).typeFor)
		var Type base = null
		var Expression size
		if (vt instanceof VectorType) {
			base = vt.base
			size = vt.size	
		} else return null
		for (var i = 1; i < e.values.size; i++) {
			vt = EcoreUtil2.copy(e.values.get(i).typeFor)
			if (vt instanceof VectorType) {
				val obase = vt.base
				val osize = vt.size
				if ((!typeCompatible(base,obase) && !typeCompatible(obase,base)) || !equalsConstExp(size,osize)) {
					return null
				} else {
					base = commonType(base,obase)
				}
			}
		}
		val t = RoboChartFactory.eINSTANCE.createMatrixType()
		t.base = base
		val n = RoboChartFactory.eINSTANCE.createIntegerExp()
		n.value = e.values.size
		// Swapped this to change representation to row-major
		t.rows = n
		t.columns = size
		return t
	}
	
	def dispatch Type typeFor(Expression e) {
		switch (e) {
			IntegerExp: {
				if(e.value >= 0) return getNatType(e) else return getIntType(e)
			}
			FloatExp: {
				return getRealType(e)
			}
			StringExp: {
				return getStringType(e)
			}
			BooleanExp: {
				return getBooleanType(e)
			}
			Neg: {
				val nat = getNatType(e)
				val integer = getIntType(e)
				val real = getRealType(e)
				val t = e.exp.typeFor
				if (typeCompatible(t, nat))
					return integer
				else if (typeCompatible(t, integer))
					return integer
				else if(typeCompatible(t, real)) 
					return real
				else if(t instanceof MatrixType) {
					val m = t as MatrixType
					if (isNumeric(m.base)) {
						val mt = RoboChartFactory.eINSTANCE.createMatrixType()
						mt.base = m.base
						mt.rows = m.rows
						mt.columns = m.columns
						return normalise(mt)
					} else return null
				} else if (t instanceof VectorType) {
					val v = t as VectorType
					if (isNumeric(v.base)) {
						val vt = RoboChartFactory.eINSTANCE.createVectorType()
						vt.base = v.base
						vt.size = v.size
						return normalise(vt)
					} else return null
				}
				else 
					return null
				
			}
			IsExp: {
				return getBooleanType(e)
			}
			AsExp: {
				val etype = e.exp.typeFor
				val type = EcoreUtil2.copy(e.type)
				if (typeCompatible(etype,type)) return normalise(type)
				else return null
			}
			Plus: {
				val nat = getNatType(e)
				val integer = getIntType(e)
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if (typeCompatible(t1, nat) && typeCompatible(t2, nat))
					return nat
				else if (typeCompatible(t1, integer) && typeCompatible(t2, integer))
					return integer
				else if(typeCompatible(t1, real) && typeCompatible(t2, real)) 
					return real
				else if(t1 instanceof MatrixType && t2 instanceof MatrixType) {
					val m1 = t1 as MatrixType
					val m2 = t2 as MatrixType
					if (isNumeric(m1.base) && isNumeric(m2.base)) {
						val base = commonType(m1.base,m2.base)
						if (equalsConstExp(m1.rows,m2.rows) && equalsConstExp(m1.columns,m2.columns)) {
							val mt = RoboChartFactory.eINSTANCE.createMatrixType()
							mt.base = base
							mt.rows = m1.rows
							mt.columns = m1.columns
							return normalise(mt)
						} else return null
					} else return null
				} else if (t1 instanceof VectorType && t2 instanceof VectorType) {
					val v1 = t1 as VectorType
					val v2 = t2 as VectorType
					if (isNumeric(v1.base) && isNumeric(v2.base)) {
						val base = commonType(v1.base,v2.base)
						if (equalsConstExp(v1.size, v2.size)) {
							val vt = RoboChartFactory.eINSTANCE.createVectorType()
							vt.base = base
							vt.size = v1.size
							return normalise(vt)
						} else return null
					} else return null
				}
				else 
					return null
			}
			Minus: {
				val integer = getIntType(e)
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if (typeCompatible(t1, integer) && typeCompatible(t2, integer))
					return integer
				else if(typeCompatible(t1, real) && typeCompatible(t2, real))
					return real
				else if(t1 instanceof MatrixType && t2 instanceof MatrixType) {
					val m1 = t1 as MatrixType
					val m2 = t2 as MatrixType
					if (isNumeric(m1.base) && isNumeric(m2.base)) {
						val base = commonType(m1.base,m2.base)
						if (equalsConstExp(m1.rows, m2.rows) && equalsConstExp(m1.columns, m2.columns)) {
							val mt = RoboChartFactory.eINSTANCE.createMatrixType()
							mt.base = base
							mt.rows = m1.rows
							mt.columns = m1.columns
							return normalise(mt)
						} else return null
					} else return null
				} else if (t1 instanceof VectorType && t2 instanceof VectorType) {
					val v1 = t1 as VectorType
					val v2 = t2 as VectorType
					if (isNumeric(v1.base) && isNumeric(v2.base)) {
						val base = commonType(v1.base,v2.base)
						if (equalsConstExp(v1.size, v2.size)) {
							val vt = RoboChartFactory.eINSTANCE.createVectorType()
							vt.base = base
							vt.size = v1.size
							return normalise(vt)
						} else return null
					} else return null
				}
				else
					return null
			}
			Mult: {
				val nat = getNatType(e)
				val integer = getIntType(e)
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if (typeCompatible(t1, nat) && typeCompatible(t2, nat))
					return nat
				else if (typeCompatible(t1, integer) && typeCompatible(t2, integer))
					return integer
				else if(typeCompatible(t1, real) && typeCompatible(t2, real)) return real 
				
				else if(t1 instanceof MatrixType && t2 instanceof MatrixType) {
					val m1 = t1 as MatrixType
					val m2 = t2 as MatrixType
					if (isNumeric(m1.base) && isNumeric(m2.base)) {
						val base = commonType(m1.base,m2.base)
						if (equalsConstExp(m1.columns, m2.rows)) {
							val mt = RoboChartFactory.eINSTANCE.createMatrixType()
							mt.base = base
							mt.rows = m1.rows
							mt.columns = m2.columns
							return normalise(mt)
						} else return null
					} else return null
				}
				else if(t1 instanceof MatrixType && t2 instanceof VectorType) {
					val m1 = t1 as MatrixType
					val m2 = t2 as VectorType
					if (isNumeric(m1.base) && isNumeric(m2.base)) {
						val base = commonType(m1.base,m2.base)
						if (equalsConstExp(m1.columns, m2.size)) {
							val mt = RoboChartFactory.eINSTANCE.createVectorType()
							mt.base = base
							mt.size = m1.rows
							return normalise(mt)
						} else return null
					} else return null
				}
				else if(t1 instanceof VectorType && t2 instanceof MatrixType) {
					val m1 = t1 as VectorType
					val m2 = t2 as MatrixType
					if (isNumeric(m1.base) && isNumeric(m2.base)) {
						val base = commonType(m1.base,m2.base)
						val one = RoboChartFactory.eINSTANCE.createIntegerExp();
						one.value = 1;
						if (equalsConstExp(one, m2.rows)) {
							val mt = RoboChartFactory.eINSTANCE.createMatrixType()
							mt.base = base
							mt.rows = m1.size
							mt.columns = m2.columns
							return normalise(mt)
						} else return null
					} else return null
				}
				else if (t1 instanceof VectorType && t2 instanceof VectorType) {
					/* this case treats multiplication of vectors as dot product */
					val v1 = t1 as VectorType
					val v2 = t2 as VectorType
					if (isNumeric(v1.base) && isNumeric(v2.base)) {
						val base = commonType(v1.base,v2.base)
						if (equalsConstExp(v1.size, v2.size)) {
							return normalise(base)
						} else return null
					} else return null
				}				
				else if ((t1 instanceof MatrixType && isNumeric(t2))) {
					val m1 = t1 as MatrixType
					if (isNumeric(m1.base)) {
						val base = commonType(m1.base,t2)
						val mt = RoboChartFactory.eINSTANCE.createMatrixType()
						mt.base = base
						mt.rows = m1.rows
						mt.columns = m1.columns
						return normalise(mt)
					} else return null
				}
				else if ((t1 instanceof VectorType && isNumeric(t2))) {
					val m1 = t1 as VectorType
					if (isNumeric(m1.base)) {
						val base = commonType(m1.base,t2)
						val mt = RoboChartFactory.eINSTANCE.createVectorType()
						mt.base = base
						mt.size = m1.size
						return normalise(mt)
					} else return null
				}
				else if ((t2 instanceof MatrixType && isNumeric(t1))) {
					val m2 = t2 as MatrixType
					if (isNumeric(m2.base)) {
						val base = commonType(m2.base,t1)
						val mt = RoboChartFactory.eINSTANCE.createMatrixType()
						mt.base = base
						mt.rows = m2.rows
						mt.columns = m2.columns
						return normalise(mt)
					} else return null
				}
				else if ((t2 instanceof VectorType && isNumeric(t1))) {
					val m2 = t2 as VectorType
					if (isNumeric(m2.base)) {
						val base = commonType(m2.base,t1)
						val mt = RoboChartFactory.eINSTANCE.createVectorType()
						mt.base = base
						mt.size = m2.size
						return normalise(mt)
					} else return null
				}
				else return null
			}
			Modulus: {
				val nat = getNatType(e)
				val integer = getIntType(e)
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if (typeCompatible(t1, nat) && typeCompatible(t2, nat))
					return nat
				else if (typeCompatible(t1, integer) && typeCompatible(t2, integer))
					return integer
				else if(typeCompatible(t1, real) && typeCompatible(t2, real)) return real else return null
			}
			Div: {
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if(typeCompatible(t1, real) && typeCompatible(t2, real)) return real else return null
			}
			SetRange: {
				val nat = getNatType(e)
				val integer = getIntType(e)
				val real = getRealType(e)
				val t1 = e.start.typeFor
				val t2 = e.end.typeFor
				val t = RoboChartFactory.eINSTANCE.createSetType
				if (typeCompatible(t1, nat) && typeCompatible(t2, nat)) {
					t.domain = nat
					return t
				} else if (typeCompatible(t1, integer) && typeCompatible(t2, integer)) {
					t.domain = integer
					return t
				} else if (typeCompatible(t1, real) && typeCompatible(t2, real)) {
					t.domain = real
					return t
				} else
					return null
			}
			RangeExp: {
				val nat = getNatType(e)
				val integer = getIntType(e)
				val real = getRealType(e)
				val t1 = e.lrange.typeFor
				val t2 = e.rrange.typeFor
				val t = RoboChartFactory.eINSTANCE.createSetType
				if (typeCompatible(t1, nat) && typeCompatible(t2, nat)) {
					t.domain = nat
					return t
				} else if (typeCompatible(t1, integer) && typeCompatible(t2, integer)) {
					t.domain = integer
					return t
				} else if (typeCompatible(t1, real) && typeCompatible(t2, real)) {
					t.domain = real
					return t
				} else
					return null
			}
			Cat: {
				val string = getStringType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if (typeCompatible(t1, string) && typeCompatible(t2, string))
					return string
				else if (t1 instanceof SeqType && t2 instanceof SeqType) {
					val st1 = (t1 as SeqType).domain
					val st2 = (t2 as SeqType).domain
					if (typeCompatible(st1, st2))
						return t2
					else if(typeCompatible(st2, st1)) return t1 else return null
				} else
					return null
			}
			LessOrEqual: {
				val bool = getBooleanType(e)
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if(typeCompatible(t1, real) && typeCompatible(t2, real)) return bool else return null
			}
			LessThan: {
				val bool = getBooleanType(e)
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if(typeCompatible(t1, real) && typeCompatible(t2, real)) return bool else return null
			}
			GreaterOrEqual: {
				val bool = getBooleanType(e)
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if(typeCompatible(t1, real) && typeCompatible(t2, real)) return bool else return null
			}
			GreaterThan: {
				val bool = getBooleanType(e)
				val real = getRealType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if(typeCompatible(t1, real) && typeCompatible(t2, real)) return bool else return null
			}
			Different: {
				val bool = getBooleanType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if(t1 !== null && t2 !== null && (typeCompatible(t1,t2) || typeCompatible(t2,t1))) return bool else return null
			}
			Equals: {
				//val v = EcoreUtil2.resolve(e.left,e.eResource.resourceSet)
				val bool = getBooleanType(e)
				val t1 = e.left.typeFor
				val t2 = e.right.typeFor
				if(t1 !== null && t2 !== null && (typeCompatible(t1,t2) || typeCompatible(t2,t1))) return bool else return null
			}
			InExp: {
				val bool = getBooleanType(e)
				val t1 = e.member.typeFor
				val t2 = e.set.typeFor
				if (t2 instanceof SetType) {
					val domain = t2.domain
					if(typeCompatible(t1, domain)) return bool else return null
				} else
					return null
			}
			ElseExp: {
				return getBooleanType(e)
			}
			TypeExp: {
				return normalise(e.type)
			}
			LetExpression: {
				return e.expression?.typeFor
			}
			TupleExp: {
				val t = RoboChartFactory.eINSTANCE.createProductType
				for (v : e.values) {
					val t1 = v.typeFor
					if(t1 === null) return null else t.types.add(EcoreUtil2.copy(t1))
				}
				return normalise(t)
			}
			Forall: {
				val bool = getBooleanType(e)
				if(typeCompatible(e.suchthat?.typeFor, bool) &&
					typeCompatible(e.predicate?.typeFor, bool)) return bool else return null
			}
			Exists: {
				val bool = getBooleanType(e)
				if(typeCompatible(e.suchthat?.typeFor, bool) &&
					typeCompatible(e.predicate?.typeFor, bool)) return bool else return null
			}
			DefiniteDescription: {
				val bool = getBooleanType(e)
				if(typeCompatible(e.suchthat?.typeFor, bool)) return e.expression.typeFor else return null
			}
			LambdaExp: {
				val bool = getBooleanType(e)
				if (e.suchthat === null || typeCompatible(e.suchthat.typeFor, bool)) {
					var t = RoboChartFactory.eINSTANCE.createFunctionType
					val range = EcoreUtil2.copy(e.expression.typeFor)
					var Type domain = null
					if (e.variables.size > 1) {
						domain = RoboChartFactory.eINSTANCE.createProductType
						for (v : e.variables) {
							if(v.type === null) return null
							(domain as ProductType).types.add(EcoreUtil2.copy(v.type))
						}
					} else if (e.variables.size === 1) {
						domain = EcoreUtil2.copy(e.variables.get(0).type)
					} else
						return null
					if (domain !== null && range !== null) {
						t.domain = domain
						t.range = range
						return normalise(t)
					} else {
						return null
					}
				} else
					return null
			}
			IfExpression: {
				val bool = getBooleanType(e)
				if (!typeCompatible(e.condition.typeFor, bool))
					return null
				else {
					val t1 = e.ifexp.typeFor
					val t2 = e.elseexp.typeFor
					if (typeCompatible(t1, t2))
						return t2
					else if(typeCompatible(t2, t1)) return t1 else return null
				}
			}
			ClockExp: {
				return getIntType(e)
			}
			StateClockExp: {
				return getIntType(e)
			}
			ResultExp: {
				val f = getFunction(e)
				if(f === null) return null else return normalise(f.type)
			}
			TransposeExp: {
				val t = e.value.typeFor
				if (t instanceof MatrixType) {
					val mt = RoboChartFactory.eINSTANCE.createMatrixType()
					mt.base = EcoreUtil2.copy(t.base)
					mt.rows = EcoreUtil2.copy(t.columns)
					mt.columns = EcoreUtil2.copy(t.rows)
					return mt
				} else if (t instanceof VectorType) {
					val mt = RoboChartFactory.eINSTANCE.createMatrixType()
					mt.base = EcoreUtil2.copy(t.base)
					val one = RoboChartFactory.eINSTANCE.createIntegerExp()
					one.value = 1
					mt.rows = one
					mt.columns = EcoreUtil2.copy(t.size)
					mt
				} else return null
			}
			InverseExp: {
				val t = e.value.typeFor
				if (t instanceof MatrixType) {
					val rows = t.rows
					val cols = t.columns
					if (equalsConstExp(rows,cols)) {
						// this condition (square matrix) is not enough for inverse to exist, but the type system cannot check that the matrix is invertible
						return EcoreUtil2.copy(t)
					} else return null
				}
			}
			default: {
				System.out.println("This case is not covered by the type checker: " + e.class.toString);
				return null
			}
		}
	}

	def Function getFunction(EObject o) {
		if (o === null)
			return null
		else if(o instanceof Function) return o else return getFunction(o.eContainer)
	}
	
	def Type normalise(Type x) {
		switch x {
			VectorType: {
				val pt = RoboChartFactory.eINSTANCE.createVectorType();
				val base = normalise(x.base)
				val size = x.size
				pt.base = EcoreUtil2.copy(base)
				pt.size = EcoreUtil2.copy(size)
				return pt
			}
			MatrixType: {
				val mt = RoboChartFactory.eINSTANCE.createMatrixType();
				val base = normalise(x.base)
				val rows = x.rows
				val columns = x.columns
				mt.base = EcoreUtil2.copy(base)
				mt.rows = EcoreUtil2.copy(rows)
				mt.columns = EcoreUtil2.copy(columns)				
				return mt
			}
			ProductType: {
				val pt = RoboChartFactory.eINSTANCE.createProductType();
				for (var i = 0; i < x.types.size; i++) {
					pt.types.add(normalise(x.types.get(i)))
				}
				return pt
			}
			FunctionType: {
				val t = RoboChartFactory.eINSTANCE.createFunctionType
				t.domain = normalise(x.domain)
				t.range = normalise(x.range)
				return t
			}
			
			RelationType: {
//				val t = RoboChartFactory.eINSTANCE.createSetType
//				val p = RoboChartFactory.eINSTANCE.createProductType
//				p.types.add(normalise(x.domain))
//				p.types.add(normalise(x.range))
//				t.domain = p
//				return t
				val t = RoboChartFactory.eINSTANCE.createRelationType
				t.domain = normalise(x.domain)
				t.range = normalise(x.range)
				return t
			}
			SeqType: {
//				val t = RoboChartFactory.eINSTANCE.createSetType
//				val p = RoboChartFactory.eINSTANCE.createProductType
//				p.types.add(normalise(x.domain))
//				val nat = getNatType(x)
//				p.types.add(EcoreUtil2.copy(nat))
//				t.domain = p
//				return t
				val t = RoboChartFactory.eINSTANCE.createSeqType
				t.domain = normalise(x.domain)
				return t
			}
			SetType: {
				val st = RoboChartFactory.eINSTANCE.createSetType();
				st.domain = normalise(x.domain)
				return st
			}
			
			
				
			default: return EcoreUtil2.copy(x)	
		}
	}

	def Boolean typeCompatible(Type x, Type y) {
		if (x === null || y === null) return false
		
		val u = unify(y,x)
		val a = normalise(instantiate(x,u))
		val b = normalise(instantiate(y,u))
		
		if (a === null || b === null)
			return false
		else if (!(a instanceof AnyType) && b instanceof AnyType)
			return true
		else if (a instanceof AnyType) {
			// this case seems to occur in situations like {} or <>, in this case identifier will be null
			if (a.identifier === null)
				return true
			else if (b instanceof AnyType) {
				val id1 = a.identifier
				val id2 = (a as AnyType).identifier
				return id1.equals(id2)
			} else
				return false
		} else if (a.class === b.class) {
			switch a {
				VectorType: {
					val sizeEq = equalsConstExp(a.size,(b as VectorType).size)
					if (!sizeEq) return false
					if (! typeCompatible(a.base, (b as VectorType).base))
						return false					
					return true
				}
				MatrixType: {
					val rowsEq = equalsConstExp(a.rows,(b as MatrixType).rows)
					val colsEq = equalsConstExp(a.columns,(b as MatrixType).columns)
					if (!colsEq) return false
					if (!rowsEq) return false
					if (! typeCompatible(a.base, (b as MatrixType).base))
						return false
					return true
				}
				ProductType: {
					if(a.types.size !== (b as ProductType).types.size) return false
					for (var i = 0; i < a.types.size; i++) {
						if (! typeCompatible(a.types.get(i), (b as ProductType).types.get(i)))
							return false
					}
					return true
				}
				FunctionType: {
					if(! typeCompatible(a.domain, (b as FunctionType).domain)) return false
					if(! typeCompatible(a.range, (b as FunctionType).range)) return false
					return true
				}
				RelationType: {
					if(! typeCompatible(a.domain, (b as RelationType).domain)) return false
					if(! typeCompatible(a.range, (b as RelationType).range)) return false
					return true
				}
				SetType: {
					if(! typeCompatible(a.domain, (b as SetType).domain)) return false else return true
				}
// A seqType is a setType, so this case is subsumed by the case above				
//				SeqType: {
//					if(! typeCompatible(a.domain, (b as SeqType).domain)) return false else return true
//				}
				TypeRef: {
					
						var t1 = a.ref
						val t2 = (b as TypeRef).ref
						if (t1 instanceof PrimitiveType && t2 instanceof PrimitiveType) {
						// the first case deals with the fact that nat subset of int, but int not subset of nat
						// because of this, type compatibility is not symmetric
							if (t1.name.equals("nat") && t2.name.equals("int"))
								return true
							else if ((t1.name.equals("nat") || t1.name.equals("int")) && t2.name.equals("real"))
								return true
							else if(t1.name.equals(t2.name)) return true else return false
						} else if (t1 instanceof Enumeration && t2 instanceof Literal) {
							return literalEnumCompatible(t2 as Literal, t1 as Enumeration)
						} else if (t2 instanceof Enumeration && t1 instanceof Literal) {
							return literalEnumCompatible(t1 as Literal, t2 as Enumeration)
						} else if(! a.ref.equalTypes((b as TypeRef).ref)) return false else return true
					
				}
				default:
					false
			}
		} else {
			val ga = getGeneralType(a)
			val gb = getGeneralType(b)
			if(ga === null && gb === null) return false
			else if (ga.class !== gb.class) return false
			else return typeCompatible(ga, gb)
		}

	}
	
	def Type getGeneralType(Type x) {
		val a = x.normalise
		
		if (a instanceof RelationType) {
			val t = RoboChartFactory.eINSTANCE.createSetType
			val p = RoboChartFactory.eINSTANCE.createProductType
			p.types.add(EcoreUtil2.copy(a.domain))
			p.types.add(EcoreUtil2.copy(a.range))
			t.domain = p
			return t
//		A functionType is a relationType, so this case is subsumed by the case above. 
// 		} else if (a instanceof FunctionType) {
//			val t = RoboChartFactory.eINSTANCE.createSetType
//			val p = RoboChartFactory.eINSTANCE.createProductType
//			p.types.add(EcoreUtil2.copy(a.domain))
//			p.types.add(EcoreUtil2.copy(a.range))
//			t.domain = p
//			return t
		} else if (a instanceof SeqType) {
			val t = RoboChartFactory.eINSTANCE.createSetType
			val p = RoboChartFactory.eINSTANCE.createProductType
			p.types.add(EcoreUtil2.copy(a.domain))
			val nat = getNatType(a)
			p.types.add(EcoreUtil2.copy(nat))
			t.domain = p
			return t
		} else if (a instanceof VectorType) {
			if (a.size instanceof IntegerExp) {
				var base = a.base 
				val sizeEq = (a.size as IntegerExp).value
				val p = RoboChartFactory.eINSTANCE.createProductType
				for (var i = 0; i < sizeEq; i++) {
					p.types.add(EcoreUtil2.copy(base))
				}
				return p
			} else return a
		} else {
			return a
		}

	}
	
	def equalTypes(TypeDecl t1, TypeDecl t2) {
		// PrimitiveType | DataType | Enumeration
		if(t1.class !== t2.class) return false else return t1.name.equals(t2.name)
	}

	def Map<String, Type> unify(Type x1, Type x2) {
		val t1 = x1.normalise
		val t2 = x2.normalise
		if (t1 instanceof AnyType && (t1 as AnyType).identifier === null) {
			// t1 is the type of an empty set or sequence
			if (t2 instanceof AnyType) {
				if (t2.identifier === null)
					return new HashMap<String, Type>()
				else {
					val map = new HashMap<String, Type>()
					map.put(t2.identifier, EcoreUtil2.copy(t1))
					return map
				}
			} else {
				return new HashMap<String, Type>()
			}
		} else if (t2 instanceof AnyType && (t2 as AnyType).identifier === null) {
			// t2 is the type of an empty set or sequence
			if (t1 instanceof AnyType) {
				if (t1.identifier === null)
					return new HashMap<String, Type>()
				else {
					val map = new HashMap<String, Type>()
					map.put(t1.identifier, t2)
					return map
				}
			} else {
				return new HashMap<String, Type>()
			}
		} else if (t1 instanceof AnyType && t2 instanceof AnyType) {
			// both are anytype, but none is the type of empty set or sequence
			// return null
			// trying to unify any types 
			val map = new HashMap<String, Type>()
			if (!(t1 as AnyType).identifier.equals((t2 as AnyType).identifier)) {
				map.put((t1 as AnyType).identifier, t2)
			}
			return map
		} else {
			if (t1.class.equals(t2.class)) {
				switch (t1) {
					VectorType: {
						val u = unify(t1.base, (t2 as VectorType).base)
						return u
					}
					MatrixType: {
						val u = unify(t1.base, (t2 as MatrixType).base)
						return u
					}
					ProductType: {
						if(t1.types.size !== (t2 as ProductType).types.size) return null
						val map = new HashMap<String, Type>()
						for (var i = 0; i < t1.types.size; i++) {
							val u = unify(t1.types.get(i), (t2 as ProductType).types.get(i))
							if (u !== null) {
								for (p : u.keySet) {
									if (map.keySet.contains(p)) {
										val mgt = mostGeneralType(map.get(p), u.get(p))
										// this case deals with inconsistent unifications of types
										if(mgt === null) return null else map.put(p, mgt)
									} else
										map.put(p, u.get(p))
								}
							} else
								return null
						}
						return map
					}
					FunctionType: {
						val u1 = unify(t1.domain, (t2 as FunctionType).domain)
						val u2 = unify(t1.range, (t2 as FunctionType).range)
						if(u1 === null || u2 === null) return null
						for (p : u1.keySet) {
							if (u2.keySet.contains(p) && !u1.get(p).equals(u2.get(p)))
								return null
						}
						u1.putAll(u2)
						return u1
					}
					RelationType: {
						val u1 = unify(t1.domain, (t2 as RelationType).domain)
						val u2 = unify(t1.range, (t2 as RelationType).range)
						if(u1 === null || u2 === null) return null
						for (p : u1.keySet) {
							if (u2.keySet.contains(p) && !u1.get(p).equals(u2.get(p)))
								return null
						}
						u1.putAll(u2)
						return u1
					}
					SetType: {
						val u = unify(t1.domain, (t2 as SetType).domain)
						if(u === null) return null
						return u
					}
// A seqType is a setType, so this case is subsumed by the case above
//					SeqType: {
//						val u = unify(t1.domain, (t2 as SeqType).domain)
//						if(u === null) return null
//						return u
//					}
					TypeRef: {
						if(t1.ref.equals((t2 as TypeRef).ref)) return new HashMap<String, Type> else return null
					}
				}
			} else {
				if (t1 instanceof AnyType) {
					val map = new HashMap<String, Type>()
					map.put((t1 as AnyType).identifier, t2)
					return map
				} else if (t2 instanceof AnyType) {
					val map = new HashMap<String, Type>()
					map.put((t2 as AnyType).identifier, t1)
					return map
				} else return null
			}
		}
	}

	def Type mostGeneralType(Type x, Type y) {
		val a = x.normalise
		val b = y.normalise
		
		if (a === null || b === null)
			return null
		else if (a instanceof AnyType && (a as AnyType).identifier === null && b instanceof AnyType &&
			(b as AnyType).identifier === null)
			return EcoreUtil2.copy(a)
		else if (a instanceof AnyType || b instanceof AnyType)
			return null
		else if (a.class !== b.class)
			return null
		else {
			switch a {
				VectorType: {
					if (a.size !== (b as VectorType).size) return null
					val t = RoboChartFactory.eINSTANCE.createVectorType
					val aux = mostGeneralType(a.base, (b as VectorType).base)
					if (aux === null) return null else t.base = aux
					return t
				}
				
				ProductType: {
					if(a.types.size !== (b as ProductType).types.size) return null
					val t = RoboChartFactory.eINSTANCE.createProductType()
					for (var i = 0; i < a.types.size; i++) {
						val aux = mostGeneralType(a.types.get(i), (b as ProductType).types.get(i))
						if(aux === null) return null else t.types.add(aux)

					}
					return t
				}
				FunctionType: {
					val t = RoboChartFactory.eINSTANCE.createFunctionType
					val t1 = mostGeneralType(a.domain, (b as FunctionType).domain)
					val t2 = mostGeneralType(a.range, (b as FunctionType).range)
					if (t1 === null || t2 === null)
						return null
					else {
						t.domain = t1
						t.range = t2
						return t
					}
				}
				RelationType: {
					val t = RoboChartFactory.eINSTANCE.createRelationType
					val t1 = mostGeneralType(a.domain, (b as RelationType).domain)
					val t2 = mostGeneralType(a.range, (b as RelationType).range)
					if (t1 === null || t2 === null)
						return null
					else {
						t.domain = t1
						t.range = t2
						return t
					}
				}
				SeqType: {
					val t = RoboChartFactory.eINSTANCE.createSeqType
					val t1 = mostGeneralType(a.domain, (b as SeqType).domain)
					if (t1 === null)
						return null
					else {
						t.domain = t1
						return t
					}
				}
				SetType: {
					val t = RoboChartFactory.eINSTANCE.createSetType
					val t1 = mostGeneralType(a.domain, (b as SetType).domain)
					if (t1 === null)
						return null
					else {
						t.domain = t1
						return t
					}
				}
				TypeRef: {
					val t1 = a.ref
					val t2 = (b as TypeRef).ref
					if (t1 instanceof PrimitiveType && t2 instanceof PrimitiveType) {
						// the first case deals with the fact that nat subset of int, but int not subset of nat
						// because of this, type compatibility is not symmetric
						if (t1.name.equals("nat") && t2.name.equals("int"))
							return EcoreUtil2.copy(b)
						else if (t2.name.equals("nat") && t1.name.equals("int"))
							return EcoreUtil2.copy(a)
						else if ((t1.name.equals("nat") || t1.name.equals("int")) && t2.name.equals("real"))
							return EcoreUtil2.copy(b)
						else if ((t2.name.equals("nat") || t1.name.equals("int")) && t1.name.equals("real"))
							return EcoreUtil2.copy(a)
						else if(t1.name.equals(t2.name)) return EcoreUtil2.copy(a) else return null
					} else if(! a.ref.equals((b as TypeRef).ref)) return null else return EcoreUtil2.copy(a)
				}
				default:
					null
			}
		}
	}

	def Type instantiate(Type x, Map<String, Type> map) {
		val a = normalise(x)
		
		if (map === null) return a
		if (a === null)
			return null
		else if (a instanceof AnyType) {
			if (a.identifier === null)
				return a
			else if(!map.containsKey(a.identifier)) return a // if the identifier !== null and is not in map, it returns null, otherwise it returns a type
			else return EcoreUtil2.copy(map.get(a.identifier))
		} else {
			switch a {
				ProductType: {
					val t = RoboChartFactory.eINSTANCE.createProductType()
					for (var i = 0; i < a.types.size; i++) {
						val aux = instantiate(a.types.get(i), map)
						if(aux === null) return null else t.types.add(aux)
					}
					return t
				}
				FunctionType: {
					val t = RoboChartFactory.eINSTANCE.createFunctionType
					val t1 = instantiate(a.domain, map)
					val t2 = instantiate(a.range, map)
					if (t1 === null || t2 === null)
						return null
					else {
						t.domain = t1
						t.range = t2
						return t
					}
				}
				RelationType: {
					val t = RoboChartFactory.eINSTANCE.createRelationType
					val t1 = instantiate(a.domain, map)
					val t2 = instantiate(a.range, map)
					if (t1 === null || t2 === null)
						return null
					else {
						t.domain = t1
						t.range = t2
						return t
					}
				}
				SeqType: {
					val t = RoboChartFactory.eINSTANCE.createSeqType
					val t1 = instantiate(a.domain, map)
					if (t1 === null)
						return null
					else {
						t.domain = t1
						return t
					}
				}
				SetType: {
					val t = RoboChartFactory.eINSTANCE.createSetType
					val t1 = instantiate(a.domain, map)
					if (t1 === null)
						return null
					else {
						t.domain = t1
						return t
					}
				}
				TypeRef: {
					return EcoreUtil2.copy(a)
				}
				VectorType: {
					val t = RoboChartFactory.eINSTANCE.createVectorType
					val base = instantiate(a.base, map)
					val size = EcoreUtil2.copy(a.size)
					if (base === null)
						return null
					else {
						t.base = base
						t.size = size
						return t
					}
				}
				MatrixType: {
					val t = RoboChartFactory.eINSTANCE.createMatrixType
					val base = instantiate(a.base, map)
					val rows = EcoreUtil2.copy(a.rows)
					val columns = EcoreUtil2.copy(a.columns)
					if (base === null)
						return null
					else {
						t.base = base
						t.rows = rows
						t.columns = columns
						return t
					}
				}
				default:
					null
			}
		}
	}
	
	def literalEnumCompatible(Literal c, Enumeration e) {
		val x = e.literals.findFirst[v|v.name.equals(c.name)]
		if (x === null) return false // the enumeration does not have a constants with the same name
		else {
			for (var i = 0; i < c.types.size; i++) {
				if (!typeCompatible(x.types.get(i), c.types.get(i))) return false						 
			}
			return true
		}
	}
	
	def boolean isNumeric(Type t) {
		val nat = getNatType(t)
		val integer = getIntType(t)
		val real = getRealType(t)
		return (typeCompatible(t,nat) || typeCompatible(t,integer) || typeCompatible(t,real))
	}
}


