package circus.robocalc.robochart.textual.naming;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.EcoreUtil2;
import org.eclipse.xtext.naming.DefaultDeclarativeQualifiedNameProvider;
import org.eclipse.xtext.naming.QualifiedName;

import circus.robocalc.robochart.ControllerDef;
import circus.robocalc.robochart.ControllerRef;
import circus.robocalc.robochart.StateMachineDef;
import circus.robocalc.robochart.StateMachineRef;

public class RoboChartQualifiedNameProvider extends DefaultDeclarativeQualifiedNameProvider {

//	public QualifiedName qualifiedName(ControllerDef c) {
//
//		List<ControllerRef> lstRefs = new ArrayList<ControllerRef>();
//		getAllRefs(c, lstRefs);
//		if(!lstRefs.isEmpty()) {
//			ControllerRef f1 = lstRefs.get(0);
//			QualifiedName refname = getFullyQualifiedName(f1);
//			System.out.println("ControllerDef qualified name: " + refname.append(c.getName()));
//			return refname.append(c.getName());
//		} else {
//			if(c.eContainer() != null) {
//				QualifiedName parentName = getFullyQualifiedName(c.eContainer());
//				if(parentName != null) {
//					List<String> segs = parentName.getSegments();
//					segs.add(c.getName());
//					return QualifiedName.create(segs);
//				}
//			}
//		}
//		return QualifiedName.create(c.getName());
//	}
//	
//	public QualifiedName qualifiedName(StateMachineDef c) {
//		
//		List<StateMachineRef> lstRefs = new ArrayList<StateMachineRef>();
//		getAllRefs(c, lstRefs);
//		if(!lstRefs.isEmpty()) {
//			StateMachineRef f1 = lstRefs.get(0);
//			QualifiedName refname = getFullyQualifiedName(f1);
//			System.out.println("StateMachineDef qualified name with reference: " + refname.append(c.getName()));
//			return refname.append(c.getName());
//		} else {
//			if(c.eContainer() != null) {
//				QualifiedName parentName = getFullyQualifiedName(c.eContainer());
//				if(parentName != null) {
//					List<String> segs = parentName.getSegments();
//					segs.add(c.getName());
//					return QualifiedName.create(segs);
//				}
//			}
//		}
//		
//		System.out.println("StateMachineDef's qualified name: " + 
//				QualifiedName.create(c.getName()).toString());
//		return QualifiedName.create(c.getName());
//	}
//	
//	private void getAllRefs(StateMachineDef obj, List<StateMachineRef> refs) {
//		EObject rootElement = EcoreUtil2.getRootContainer(obj);
//		List<StateMachineRef> candidates = EcoreUtil2.getAllContentsOfType(rootElement, StateMachineRef.class);
//		for(StateMachineRef c : candidates) {
//			System.out.println("[StateMachineRef]getAllRefs: " + c.toString());
//			if(c.getRef() != null && c.getRef() == obj) {
//				refs.add(c);
//			}
//		}
//	}
//	
//	private void getAllRefs(ControllerDef obj, List<ControllerRef> refs) {
//		EObject rootElement = EcoreUtil2.getRootContainer(obj);
//		List<ControllerRef> candidates = EcoreUtil2.getAllContentsOfType(rootElement, ControllerRef.class);
//		for(ControllerRef c : candidates) {
//			System.out.println("[ControllerRef]getAllRefs: " + c.toString());
//			if(c.getRef() == obj) {
//				refs.add(c);
//			}
//		}
//	}
}
