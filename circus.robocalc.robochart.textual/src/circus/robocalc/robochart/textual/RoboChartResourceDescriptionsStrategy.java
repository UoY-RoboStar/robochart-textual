package circus.robocalc.robochart.textual;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.EcoreUtil2;
import org.eclipse.xtext.naming.QualifiedName;
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

	@Inject RoboChartQualifiedNameProvider qnp;
	
	@Override
	public boolean createEObjectDescriptions(EObject e, IAcceptor<IEObjectDescription> acceptor) {
		if (e instanceof StateMachineDef) {
			System.out.println("[createEObjectDescriptions]getAllRefs: " + e);
			List<StateMachineRef> lstRefs = new ArrayList<StateMachineRef>();
			getAllRefs((StateMachineDef)e, lstRefs);
			for(StateMachineRef ref: lstRefs) {
				QualifiedName refname = qnp.getFullyQualifiedName(ref);
				
				if (refname != null) {
					
					acceptor.accept(EObjectDescription.create(
							refname.append(((StateMachineDef)e).getName()), e));
					acceptor.accept(EObjectDescription.create(
							refname.append("[STM]" + ((StateMachineDef)e).getName()), e));
				}
			}
			
			return true;
		} 
		
		return super.createEObjectDescriptions(e, acceptor);
	}
	
	private void getAllRefs(StateMachineDef obj, List<StateMachineRef> refs) {
		EObject rootElement = EcoreUtil2.getRootContainer(obj);
		List<StateMachineRef> candidates = EcoreUtil2.getAllContentsOfType(rootElement, StateMachineRef.class);
		for(StateMachineRef c : candidates) {
			// System.out.println("[StateMachineRef]getAllRefs: " + c.toString());
			if(c.getRef() != null && c.getRef() == obj) {
				refs.add(c);
			}
		}
	}
	
	private void getAllRefs(ControllerDef obj, List<ControllerRef> refs) {
		EObject rootElement = EcoreUtil2.getRootContainer(obj);
		List<ControllerRef> candidates = EcoreUtil2.getAllContentsOfType(rootElement, ControllerRef.class);
		for(ControllerRef c : candidates) {
			System.out.println("[ControllerRef]getAllRefs: " + c.toString());
			if(c.getRef() == obj) {
				refs.add(c);
			}
		}
	}
	
}
