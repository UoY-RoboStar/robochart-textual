package circus.robocalc.robochart.textual;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.EcoreUtil2;
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
import circus.robocalc.robochart.StateMachineDef;
import circus.robocalc.robochart.StateMachineRef;

@Singleton
public class RoboChartResourceDescriptionsStrategy extends DefaultResourceDescriptionStrategy {

	@Inject RoboChartQualifiedNameProvider qualifiedNameProvider;
	@Inject  SimpleNameProvider simNameProvider;
	
	@Override
	public boolean createEObjectDescriptions(EObject e, IAcceptor<IEObjectDescription> acceptor) {
		if (e instanceof StateMachineDef) {
			List<EObject> allElements = EcoreUtil2.eAllContentsAsList(e);
			
//			System.out.println("[createEObjectDescriptions]getAllRefs: " + e);
			List<StateMachineRef> lstRefs = new ArrayList<StateMachineRef>();
			getAllRefs((StateMachineDef)e, lstRefs);
			for(StateMachineRef ref: lstRefs) {
				QualifiedName refname = qualifiedNameProvider.getFullyQualifiedName(ref);
				
				if (refname != null) {
					acceptor.accept(EObjectDescription.create(
							refname.append(((StateMachineDef)e).getName()), e));
					for(EObject ele: allElements) {
						QualifiedName eleName = simNameProvider.getFullyQualifiedName(ele);
						if(eleName != null) {
							System.out.println("createEObjectDescriptions for StateMachineDef/Element:" + eleName.toString());
							acceptor.accept(EObjectDescription.create(
									refname.append(eleName), e));
						}
					}
				}
			}
			
			return true;
		} else if (e instanceof ControllerDef) {
			List<EObject> allElements = EcoreUtil2.eAllContentsAsList(e);
			
			List<ControllerRef> lstRefs = new ArrayList<ControllerRef>();
			getAllRefs((ControllerDef)e, lstRefs);
			for(ControllerRef ref: lstRefs) {
				QualifiedName refname = qualifiedNameProvider.getFullyQualifiedName(ref);
				
				if (refname != null) {
					acceptor.accept(EObjectDescription.create(
							refname.append(((ControllerDef)e).getName()), e));
					for(EObject ele: allElements) {
						System.out.println("ControllerDef/Element:" + ele.toString());
						
						QualifiedName eleName = simNameProvider.getFullyQualifiedName(ele);
						if(eleName != null) {
							System.out.println("createEObjectDescriptions for ControllerDef/Element:" + eleName.toString());
							acceptor.accept(EObjectDescription.create(
									refname.append(eleName), e));
						}
					}
				}
			}
			
			return true;
		}
		
		return super.createEObjectDescriptions(e, acceptor);
	}
	
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
	
}
