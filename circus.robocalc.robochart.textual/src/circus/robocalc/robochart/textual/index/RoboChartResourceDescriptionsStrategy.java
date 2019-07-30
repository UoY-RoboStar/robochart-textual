package circus.robocalc.robochart.textual.index;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.EcoreUtil2;
import org.eclipse.xtext.naming.DefaultDeclarativeQualifiedNameProvider;
import org.eclipse.xtext.naming.QualifiedName;
import org.eclipse.xtext.naming.SimpleNameProvider;
import org.eclipse.xtext.resource.EObjectDescription;
import org.eclipse.xtext.resource.IEObjectDescription;
import org.eclipse.xtext.resource.impl.DefaultResourceDescriptionStrategy;
import org.eclipse.xtext.util.IAcceptor;

import com.google.inject.Inject;
import com.google.inject.Singleton;

import circus.robocalc.robochart.ControllerDef;
import circus.robocalc.robochart.ControllerRef;
import circus.robocalc.robochart.RoboChartFactory;
import circus.robocalc.robochart.State;
import circus.robocalc.robochart.StateMachineDef;
import circus.robocalc.robochart.StateMachineRef;
import circus.robocalc.robochart.Type;
import circus.robocalc.robochart.Variable;
import circus.robocalc.robochart.VariableModifier;

@Singleton
public class RoboChartResourceDescriptionsStrategy extends DefaultResourceDescriptionStrategy {

	@Inject DefaultDeclarativeQualifiedNameProvider qualifiedNameProvider;
	@Inject SimpleNameProvider simNameProvider;
	
	@Override
	public boolean createEObjectDescriptions(EObject e, IAcceptor<IEObjectDescription> acceptor) {
		if (e instanceof StateMachineDef) {
			// 1. get all elements of this StateMachineDef
			List<EObject> allElements = EcoreUtil2.eAllContentsAsList(e);
			
			// 2. get all references to this StateMachineDef
//			System.out.println("[createEObjectDescriptions]getAllRefs: " + e);
			List<StateMachineRef> lstRefs = new ArrayList<StateMachineRef>();
			getAllRefs((StateMachineDef)e, lstRefs);
			
			// 3. if there is some references, then ...
			// otherwise, if there is no reference, just leave it as it is because default behaviour will create EObjectDescription for them
			for(StateMachineRef ref: lstRefs) {
				// if the StateMachineRef is in a ControllerDef, then the ControllerDef might be referred from multiple places as well.
//				System.out.println("createEObjectDescriptions for StateMachineDef/eContainer: " + ref.eContainer());
				if(ref.eContainer() instanceof ControllerDef) {
					// 4. get all controller references to this ControllerDef
					List<ControllerRef> lstCtrlRefs = new ArrayList<ControllerRef>();
					getAllRefs((ControllerDef)ref.eContainer(), lstCtrlRefs);
					
					// 5. if there is some controller references, we create [ctrlref].stmref 
					//	 as well as all elements in this stmref as [ctrlref].stmref.ele
					if(!lstCtrlRefs.isEmpty()) {
						for(ControllerRef ctrl_ref: lstCtrlRefs) {
							QualifiedName refname = qualifiedNameProvider.getFullyQualifiedName(ctrl_ref);
							
							if (refname != null) {
								refname = refname.append(ref.getName());
								// references to stmref from ctrlref are not needed to be created here because they will be created in ControllerDef below
//								System.out.println("= Create reference [" + refname.toString() + "] to " + ref.getName());
//								// the reference to the state machine
//								acceptor.accept(EObjectDescription.create(refname, e));
								for(EObject ele: allElements) {
									QualifiedName eleName = qualifiedNameProvider.getFullyQualifiedName(ele);
									// extract the element's partial qualified name by removing its prefix till stmdef
									// (such as ....stmdef.state0.state1.ele by state0.state1.ele)
									if(eleName != null) {
										eleName = removePrefix(eleName, ((StateMachineDef)e).getName());
										System.out.println("createEObjectDescriptions for StateMachineDef/Element:" + refname.toString() + "+" + eleName.toString());
										acceptor.accept(EObjectDescription.create(
												refname.append(eleName), ele));
									}
								}
							}
						}
					} else {
						// 6. if there is no controller references, then we shouldn't create [ctrldef].stmref 
						//	since it should be created by default, but we should create all elements in this stmref 
						// as [ctrldef].stmref.ele 
						QualifiedName refname = qualifiedNameProvider.getFullyQualifiedName(ref.eContainer());
						if (refname != null) {
							refname = refname.append(ref.getName());
							for(EObject ele: allElements) {
								QualifiedName eleName = qualifiedNameProvider.getFullyQualifiedName(ele);
								
								if(eleName != null) {
									eleName = removePrefix(eleName, ((StateMachineDef)e).getName());
									System.out.println("createEObjectDescriptions for StateMachineDef/Element:" + refname.toString() + "+" + eleName.toString());
									acceptor.accept(EObjectDescription.create(
											refname.append(eleName), ele));
								}
							}
						}
					}
				} else {
						System.err.println("A state machine reference's parent must be ControllerDef, but it is " + ref.eContainer());
//					QualifiedName refname = qualifiedNameProvider.getFullyQualifiedName(ref);
//					
//					if (refname != null) {
//						/* System.out.println("== Create reference [" + refname.toString() + "] to " + ref.getName());
//						// the reference to the state machine
//						acceptor.accept(EObjectDescription.create(refname, e));*/
//						for(EObject ele: allElements) {
//							QualifiedName eleName = simNameProvider.getFullyQualifiedName(ele);
//							if(eleName != null) {
//								System.out.println("createEObjectDescriptions for StateMachineDef/Element:" + refname.toString() + "." + eleName.toString());
//								acceptor.accept(EObjectDescription.create(
//										refname.append(eleName), e));
//							}
//						}
//					}
				}
			}
			
			// return true;
		} else if (e instanceof ControllerDef) {
			List<EObject> allElements = EcoreUtil2.eAllContentsAsList(e);
			
			List<ControllerRef> lstRefs = new ArrayList<ControllerRef>();
			getAllRefs((ControllerDef)e, lstRefs);
			for(ControllerRef ref: lstRefs) {
				QualifiedName refname = qualifiedNameProvider.getFullyQualifiedName(ref);
				
				if (refname != null) {
					/* System.out.println("=== Create reference [" + refname.toString() + "] to " + ref.getName());
					acceptor.accept(EObjectDescription.create(
							refname.append(((ControllerDef)e).getName()), e)); */
					for(EObject ele: allElements) {
//						System.out.println("ControllerDef/Element:" + ele.toString());
						
						QualifiedName eleName = qualifiedNameProvider.getFullyQualifiedName(ele);
						if(eleName != null) {
							eleName = removePrefix(eleName, ((ControllerDef)e).getName());
							System.out.println("createEObjectDescriptions for ControllerDef/Element:" + refname.toString() + "." + eleName.toString());
							acceptor.accept(EObjectDescription.create(
									refname.append(eleName), e));
						}
					}
				}
			}
			
			// return true;
		}
		
		return super.createEObjectDescriptions(e, acceptor);
	}
	
	/**
	 * Get all state machine references to the state machine definition
	 * @param obj
	 * @param refs
	 */
	private void getAllRefs(StateMachineDef obj, List<StateMachineRef> refs) {
		EObject rootElement = EcoreUtil2.getRootContainer(obj);
		List<StateMachineRef> candidates = 
				EcoreUtil2.getAllContentsOfType(rootElement, StateMachineRef.class);
		for(StateMachineRef c : candidates) {
			// System.out.println("[StateMachineRef]getAllRefs: " + c.toString());
			if(c.getRef() != null && c.getRef() == obj) {
				refs.add(c);
			}
		}
	}
	
	/**
	 * Get all controllers references to the controller definition
	 * @param obj
	 * @param refs
	 */
	private void getAllRefs(ControllerDef obj, List<ControllerRef> refs) {
		EObject rootElement = EcoreUtil2.getRootContainer(obj);
		List<ControllerRef> candidates = 
				EcoreUtil2.getAllContentsOfType(rootElement, ControllerRef.class);
		for(ControllerRef c : candidates) {
//			System.out.println("[ControllerRef]getAllRefs: " + c.toString());
			if(c.getRef() != null && c.getRef() == obj) {
				refs.add(c);
			}
		}
	}
	
	/**
	 * Remove prefixing segments till the given one.
	 * For instance, removePrefix("a.b.c.d", "b") will return "c.d"
	 * @param name
	 * @param endseg
	 * @return
	 */
	private QualifiedName removePrefix(QualifiedName name, String endseg) {
		List<String> newQualifiedName = new ArrayList<String>();
		if(name != null) {
			List<String> lstStr = name.getSegments();
			if(lstStr.indexOf(endseg) != -1 && lstStr.indexOf(endseg)+1 < lstStr.size()) {
				newQualifiedName.addAll(lstStr.subList(lstStr.indexOf(endseg)+1, lstStr.size()));
				return QualifiedName.create(newQualifiedName);
			} else {
				return name;
			}
		} else {
			return QualifiedName.create(newQualifiedName);
		}
	}
	
	private boolean isCompositeState(State s) {
		if(s != null) {
			if(!(s.getNodes().isEmpty()) && !(s.getTransitions().isEmpty()) ) {
				return true;
			}
		}
		
		return false;
	}

//	private void createAddVariables(EObject s, QualifiedName name, IAcceptor<IEObjectDescription> acceptor) {
//		if(s instanceof StateMachineDef) {
//			
//		} else if(s instanceof State) {
//			if(isCompositeState((State)s)) {
//				
//				System.out.println("createEObjectDescriptions for StateMachineDef/Element:" + name.toString() + "+" + "scpc");
//				Variable scpc = RoboChartFactory.eINSTANCE.createVariable();
//				scpc.setName("scpc");
//				scpc.setModifier(VariableModifier.VAR);
//				scpc.setType(getIntType(s));
//				acceptor.accept(EObjectDescription.create(
//						name.append("scpc"), ));
//			}
//		}
//	}
}
