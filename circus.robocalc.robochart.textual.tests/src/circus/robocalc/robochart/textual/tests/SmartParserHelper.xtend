package circus.robocalc.robochart.textual.tests

import circus.robocalc.robochart.textual.RoboChartStandaloneSetup
import com.google.inject.Inject
import com.google.inject.Provider
import java.io.File
import java.io.IOException
import java.io.InputStream
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.util.Enumeration
import java.util.Iterator
import java.util.Map
import java.util.jar.JarEntry
import java.util.jar.JarFile
import java.util.stream.Stream
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.common.util.WrappedException
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.testing.util.ParseHelper

/*
 * code based on answer by Christian Dietrich in https://www.eclipse.org/forums/index.php/t/1068376/
 */
class SmartParserHelper<T extends EObject> extends ParseHelper<T> {
	@Inject Provider<XtextResourceSet> rsp;

	def loadRoboChartLibrary(ResourceSet rs) {
		val classLoader = RoboChartStandaloneSetup.classLoader
		// solution to find files in jar file from https://stackoverflow.com/questions/11012819/how-can-i-get-a-resource-folder-from-inside-my-jar-file
		val jarFile = new File(RoboChartStandaloneSetup.protectionDomain.codeSource.location.path)
		if (jarFile.isFile()) {
			// treating case where the resource files are in a plugin
			val jar = new JarFile(jarFile)
			val Enumeration<JarEntry> entries = jar.entries(); // gives ALL entries in jar
			while (entries.hasMoreElements()) {
				val name = entries.nextElement().getName();
				if (name.startsWith("lib/robochart/") && name.endsWith(".rct")) { // filter according to the path
					val url = classLoader.getResource(name)
					val input = url.toURI.toURL.openStream
					val uri = URI.createFileURI(url.path)
					val res = rs.createResource(uri)
					res.load(input, rs.loadOptions)
				}
			}
			jar.close();
		} else {
			// treating case where the resource files are a project in the workspace			
			var url = classLoader.getResource("lib/robochart");
			if (url === null) {
				url = classLoader.getResource("robochart");
			}
			val path = Paths.get(url.toURI)
			var Stream<Path> walk = Files.list(path);
			for (var Iterator<Path> it = walk.iterator(); it.hasNext();) {
				val p = it.next()
				val is = p.toUri().toURL.openStream;
				val furi = URI.createFileURI(p.toUri.toURL.path)
				val r = rs.createResource(furi)
				r.load(is, rs.loadOptions)
			}
			walk.close();
		}
	}

	def createResourceSet() {
		val rs = rsp.get();
		// loading robochart libraries
		loadRoboChartLibrary(rs)

		return rs;
	}

	def T parse(CharSequence text, ResourceSet resourceSetToUse, String fileExtension) throws Exception {
		return parse(getAsStream(text), computeUnusedUri(resourceSetToUse, fileExtension), null, resourceSetToUse,
			fileExtension) as T
	}

	def URI computeUnusedUri(ResourceSet resourceSet, String fileExtension) {
		val String name = "__synthetic";
		for (i : 0 .. Integer.MAX_VALUE) {
			val URI syntheticUri = URI.createURI(name + i + "." + fileExtension);
			if (resourceSet.getResource(syntheticUri, false) === null)
				return syntheticUri;
		}
		throw new IllegalStateException();
	}

	override T parse(CharSequence text) throws Exception {
		val rs = createResourceSet()
		parse(getAsStream(text), computeUnusedUri(rs, fileExtension), null, rs, fileExtension) as T
	}

	def T parse(InputStream in, URI uriToUse, Map<?, ?> options, ResourceSet resourceSet, String fileExtension) {
		val Resource resource = resourceSet.createResource(uriToUse);
		try {
			resource.load(in, options);
			val T root = if(resource.getContents().isEmpty()) null else resource.getContents().get(0) as T;
			return root;
		} catch (IOException e) {
			throw new WrappedException(e);
		}
	}
}
