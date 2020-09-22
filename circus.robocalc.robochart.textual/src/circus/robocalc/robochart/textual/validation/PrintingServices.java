package circus.robocalc.robochart.textual.validation;

import org.eclipse.xtext.naming.IQualifiedNameProvider;

import com.google.inject.Inject;

import circus.robocalc.robochart.AnyType;
import circus.robocalc.robochart.Expression;
import circus.robocalc.robochart.FloatExp;
import circus.robocalc.robochart.FunctionType;
import circus.robocalc.robochart.IntegerExp;
import circus.robocalc.robochart.MatrixType;
import circus.robocalc.robochart.NamedExpression;
import circus.robocalc.robochart.ProductType;
import circus.robocalc.robochart.RefExp;
import circus.robocalc.robochart.RelationType;
import circus.robocalc.robochart.SeqType;
import circus.robocalc.robochart.SetType;
import circus.robocalc.robochart.Type;
import circus.robocalc.robochart.TypeRef;
import circus.robocalc.robochart.Variable;
import circus.robocalc.robochart.VariableModifier;
import circus.robocalc.robochart.VectorType;

public class PrintingServices {

	@Inject
	IQualifiedNameProvider qnp;
	
	public String printConstantExp(Expression e) {
		if (e instanceof RefExp) {
			NamedExpression ne = ((RefExp) e).getRef();
			if (ne instanceof Variable && ((Variable)ne).getModifier() == VariableModifier.CONST) {
				return ((Variable)ne).getName();
			} else return null;
		} else if (e instanceof IntegerExp) {
			return String.valueOf(((IntegerExp)e).getValue());
		} else if (e instanceof FloatExp) {
			return String.valueOf(((FloatExp)e).getValue());
		} else return null;
	}

	public String printType(Type t) {
		if (t instanceof TypeRef) {
			return ((TypeRef) t).getRef().getName();
		} else if (t instanceof VectorType) {
			VectorType vt = (VectorType) t;
			Expression n = vt.getSize();
			String s = printType(vt.getBase());
			return "vector("+s+","+printConstantExp(n)+")";
		} else if (t instanceof MatrixType) {
			MatrixType vt = (MatrixType) t;
			Expression r = vt.getRows();
			Expression c = vt.getColumns();
			String s = printType(vt.getBase());
			return "matrix("+s+","+printConstantExp(r)+","+printConstantExp(c)+")";
		} else if (t instanceof ProductType) {
			ProductType pt = (ProductType) t;
			int i = 1;
			String s = printType(pt.getTypes().get(0));
			while (i < pt.getTypes().size()) {
				s += "*" + printType(pt.getTypes().get(i));
				i++;
			}
			return s;
		} else if (t instanceof FunctionType) {
			FunctionType ft = (FunctionType) t;
			String t1 = printType(ft.getDomain());
			String t2 = printType(ft.getRange());
			return t1 + "->" + t2;
		} else if (t instanceof RelationType) {
			RelationType ft = (RelationType) t;
			String t1 = printType(ft.getDomain());
			String t2 = printType(ft.getRange());
			return t1 + "<->" + t2;
		} else if (t instanceof SetType) {
			SetType st = (SetType) t;
			String t1 = printType(st.getDomain());
			return "Set(" + t1 + ")";
		} else if (t instanceof SeqType) {
			SeqType st = (SeqType) t;
			String t1 = printType(st.getDomain());
			return "Seq(" + t1 + ")";
		} else if (t instanceof AnyType) {
			return "?" + ((AnyType) t).getIdentifier();
		} else
			return null;
	}

//	public int numberOfStates(NodeContainer n, String name) {
//		int i = 0;
//		if (n instanceof State && !(n instanceof Final)) {
//			if (((State) n).getName().equals(name)) {
//				i++;
//			}
//		}
//		for (EObject x : n.getNodes()) {
//			if (x instanceof NodeContainer) {
//				i += numberOfStates((NodeContainer) x, name);
//			}
//		}
//		return i;
//	}
//
//	public String fullName(State state) {
//		State aux = state;
//		String s = aux.getName();
//		while (aux.eContainer() instanceof State) {
//			aux = (State) aux.eContainer();
//			s += "::" + aux.getName();
//		}
//		return s;
//	}
//
//	public StateMachineDef getStateMachineDef(State s) {
//		EObject aux = s;
//		while (aux != null && !(aux instanceof StateMachineDef)) {
//			aux = aux.eContainer();
//		}
//		if (aux instanceof StateMachineDef) {
//			return (StateMachineDef) aux;
//		} else {
//			return null;
//		}
//	}
//
//	// Operations and functions
//	public String printFunction(Function f) {
//		String s = f.getName() + "(";
//		if (f.getParameters().size() > 0) {
//			Parameter v = f.getParameters().get(0);
//			s += v.getName() + ": " + printType(v.getType());
//		}
//		for (int i = 1; i < f.getParameters().size(); i++) {
//			Variable v = f.getParameters().get(i);
//			s += ", " + v.getName() + ": " + printType(v.getType());
//		}
//		s += "): " + printType(f.getType());
//		return s;
//	}
//
//
//	// References
//
//	public List<EObject> path(NamedElement o1) {
//		List<EObject> l = new ArrayList<EObject>();
//		l.add(o1);
//		EObject o = o1;
//		while (o.eContainer() != null && o.eContainer() instanceof RCPackage) {
//			o = o.eContainer();
//			if (o instanceof NamedElement)
//				l.add(o);
//		}
//		if (o instanceof RCPackage) {
//			l.add(o);
//		}
//		Collections.reverse(l);
//		return l;
//	}
//
//	public EObject lca(NamedElement o1, NamedElement o2) {
//		List<EObject> l1, l2;
//		l1 = path(o1);
//		l2 = path(o2);
//		// if the package is not the same, there is not least common ancestor
//		if (l1.get(0) != l2.get(0))
//			return null;
//		else {
//			// traverse both lists until they differ
//			EObject lac = l1.get(0);
//			for (int i = 1; i < l1.size() && i < l2.size(); i++) {
//				if (l1.get(i) == l2.get(i)) {
//					lac = l1.get(i);
//				} else {
//					break;
//				}
//			}
//			return lac;
//		}
//	}
//
//	public String printStateMachineRef(StateMachineRef e) {
//		NamedElement o1 = e;
//		NamedElement o2 = e.getRef();
//		EObject l = lca(o1, o2);
//		String s = e.getRef().getName();
//		EObject o = e.getRef();
//		while (o.eContainer() != null && o.eContainer() != l) {
//			o = o.eContainer();
//			if (o instanceof RCPackage && ((RCPackage) o).getName() != null) {
//				s = ((RCPackage) o).getName() + "::" + s;
//			}
//			if (o instanceof NamedElement) {
//				s = ((NamedElement) o).getName() + "::" + s;
//			}
//		}
//		return "ref " + s;
//	}
//
//	public String printControllerRef(ControllerRef e) {
//		NamedElement o1 = e;
//		NamedElement o2 = e.getRef();
//		EObject l = lca(o1, o2);
//		String s = e.getRef().getName();
//		EObject o = e.getRef();
//		while (o.eContainer() != null && o.eContainer() != l) {
//			o = o.eContainer();
//			if (o instanceof RCPackage && ((RCPackage) o).getName() != null) {
//				s = ((RCPackage) o).getName() + "::" + s;
//			}
//			if (o instanceof NamedElement) {
//				s = ((NamedElement) o).getName() + "::" + s;
//			}
//		}
//		return "ref " + s;
//	}
//
//	public String printRoboticPlatformRef(RoboticPlatformRef e) {
//		NamedElement o1 = e;
//		NamedElement o2 = e.getRef();
//		EObject l = lca(o1, o2);
//		String s = e.getRef().getName();
//		EObject o = e.getRef();
//		while (o.eContainer() != null && o.eContainer() != l) {
//			o = o.eContainer();
//			if (o instanceof RCPackage && ((RCPackage) o).getName() != null) {
//				s = ((RCPackage) o).getName() + "::" + s;
//			}
//			if (o instanceof NamedElement) {
//				s = ((NamedElement) o).getName() + "::" + s;
//			}
//		}
//		return "ref " + s;
//	}
//
//	// Interfaces
//
//	// Transitions and connections
//
//	public String printConnection(Connection c) {
//		// if (c.getTo() instanceof RoboticPlatform || c.getFrom() instanceof
//		// RoboticPlatform) {
//		// return "";
//		// } else
//		if (c.isAsync())
//			return "async";
//		else
//			return "";
//	}
//
//	public String printTransition(Transition t) {
//		if (t != null) {
//			Expression cond = t.getCondition();
//			Statement a = t.getAction();
//			Trigger trigger = t.getTrigger();
//			Expression startDeadline = t.getStart();
//			Expression endDeadline = t.getEnd();
//			Expression probability = t.getProbability();
//
//			String value = "";
//
//			if (probability != null) {
//				value += "p{" + print(probability) + "}";
//			}
//			if (startDeadline != null) {
//				value += "{" + print(startDeadline) + "}> ";
//			}
//
//			if (trigger != null) {
//				if (trigger.get_type() != TriggerType.EMPTY) {
//					value += trigger.getEvent().getName();
//					if (trigger.get_from() != null || trigger.get_predicate() != null) {
//						value += "[|";
//						if (trigger.get_from() != null)
//							value += trigger.get_from().getName() + " = from";
//						if (trigger.get_from() != null && trigger.get_predicate() != null)
//							value += " | ";
//						if (trigger.get_predicate() != null)
//							value += print(trigger.get_predicate());
//						value += "|]";
//					}
//
//					if (trigger.get_type() == TriggerType.INPUT) {
//						value += "?" + trigger.getParameter().getName();
//					} else if (trigger.get_type() == TriggerType.OUTPUT) {
//						value += "!" + print((trigger).getValue());
//					} else if (trigger.get_type() == TriggerType.SYNC) {
//						value += "." + print((trigger).getValue());
//					}
//				}
//				try {
//					Variable timeElapsed = trigger.getTime();
//					if (timeElapsed != null) {
//						value += " @" + timeElapsed.getName();
//					}
//
//					EList<ClockReset> resets = trigger.getReset();
//					for (ClockReset c : resets) {
//						Clock timer = c.getClock();
//						if (timer != null) {
//							value += " #" + timer.getName();
//						}
//					}
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//
//			if (endDeadline != null) {
//				value += " <{" + print(endDeadline) + "}";
//			}
//
//			if (cond != null) {
//				try {
//					String v = print(cond);
//					value += "[" + v + "]";
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//			if (a != null) {
//				value += "/" + print(a);
//			}
//			return value;
//		}
//		return null;
//	}
//
//	// Packages and Imports
//
//	// Modules, Collections
//
//	// Types
}
