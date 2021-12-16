package circus.robocalc.robochart.textual.generator;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

import org.eclipse.core.resources.IContainer;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.IWorkspaceRoot;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.core.runtime.ISafeRunnable;
import org.eclipse.core.runtime.SafeRunner;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.URIConverter;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.xtext.resource.XtextResourceSet;

/**
 * 
 * @author Pedro Ribeiro
 * 
 * Adapted from class org.eclise.emj.util.ProjectUtilities
 * and https://www.eclipse.org/forums/index.php/t/261453/.
 * 
 * This class aims to support resolving project resources.
 *
 */

public class ProjectUtilities {
	
//	public static boolean includeResourceOfExtension(String extension) {
//		return "rct".equals(extension) || "assertions".equals(extension);
//	}
	
	public static List<IFile> getAllResourceFiles(Function<String,Boolean> filetype, IContainer project) throws CoreException {
		IResource[] members = project.members();
		ArrayList<IFile> list = new ArrayList<IFile>();
		for (IResource member : members) {
			if (member instanceof IContainer) {
				list.addAll(getAllResourceFiles(filetype,(IContainer) member));
			} else if (member instanceof IFile && filetype.apply(member.getFileExtension())) {
				list.add((IFile) member);
			}
		}
		return list;
	}

	public static void resolveDependencies(Function<String,Boolean> filetype, Resource resource) {
		
		// Resolve all dependencies beforehand
		ISafeRunnable resolver = new ISafeRunnable() {
			
			public void handleException(Throwable e) {
				System.err.println(e.getMessage());
			}

			public void run() throws Exception {
				
				IProject project = ProjectUtilities.getProject(resource);
				if (project != null) {
					List<IFile> files = getAllResourceFiles(filetype,project);
					ResourceSet rs = resource.getResourceSet();
					List<Resource> rlist = new ArrayList<Resource>();
					for (IFile f : files) {
						URI uri = URI.createURI(f.getFullPath().toString());
						Resource r = rs.getResource(uri, true);
						rlist.add(r);
					}
					EcoreUtil.resolveAll(rs);
				}
			}
			
		};
		
		SafeRunner.run(resolver);
	}
	
	/**
     * Get the project associated with the given object.
     * 
     * @param object
     *            may be an <code>IProject, IResource, IAdaptable (to an IProject), EObject (gets IProject if object is in a ProjectResourceSet</code>.
     * @param natureId
     *            if <code>null</code> then returns project. If not <code>null</code> then returns project only if project has this nature id.
     * @return project associated with the object or <code>null</code> if not found.
     * 
     * @since 1.0.0
     */
    public static IProject getProject(Object object, String natureId) {
        IProject result = getProject(object);
        if (natureId == null)
            return result;
        if (result != null && result.isAccessible() && natureId != null)
            try {
                if (result.hasNature(natureId))
                    return result;
            } catch (CoreException e) {
                //Logger.getLogger().logError(e);
            }
        return null;
    }
 
    /**
     * Get the project associated with the given object.
     * 
     * @param object
     *            may be an <code>IProject, IResource, IAdaptable (to an IProject), EObject (gets IProject if object is in a ProjectResourceSet</code>.
     * @return project associated with the object or <code>null</code> if not found.
     * 
     * @since 1.0.0
     */
    public static IProject getProject(Object object) {
        IProject result = null;
 
        if (object instanceof IProject)
            result = (IProject) object;
        else if (object instanceof IResource)
            result = ((IResource) object).getProject();
        else if (object instanceof IAdaptable)
            result = (IProject) ((IAdaptable) object).getAdapter(IProject.class);
        else if (object instanceof EObject)
            result = getProject((EObject) object);
 
        return result;
    }
 
    /**
     * Get the project associated with the given EObject. (If in a ProjectResourceSet, then the project from that resource set).
     * 
     * @param aRefObject
     * @return project if associated or <code>null</code> if not found.
     * 
     * @since 1.0.0
     */
    public static IProject getProject(EObject aRefObject) {
        if (aRefObject != null) {
            Resource resource = aRefObject.eResource();
            return getProject(resource);
        }
        return null;
    }
 
    /**
     * Get the project associated with the given Resource. 
     * 
     * @param resource
     * @return project if associated or <code>null</code> if not found.
     * 
     * @since 1.0.0
     * 
     * Adapted from: https://www.eclipse.org/forums/index.php/t/261453/
     */
    public static IProject getProject(Resource aresource) {
        URI uri = aresource.getURI();
        uri = uri.trimFragment();
        // remove "platform:..." from uri
        if (uri.isPlatform()) {
            uri = URI.createURI( uri.toPlatformString( true ) );
        }

        IProject project = null;
        
        try {
        	IWorkspaceRoot workspaceRoot = ResourcesPlugin.getWorkspace().getRoot();
	        // try to get project from whole uri resource
	        IResource resource = workspaceRoot.findMember( uri.toString() );
	        if (resource != null) {
	            project = resource.getProject();
	        }
	        
	        // another try,by first segment with project name
	        if (project == null && uri.segmentCount() > 0) {
	            String projectName = uri.segment( 0 );
	            IResource projectResource = workspaceRoot.findMember( projectName );
	            if (projectResource != null) {
	                project = projectResource.getProject();
	            }
	        }
	        
        } catch (Exception e) {
        	
        }
        
        return project;   
    }
	
}
