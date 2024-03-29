/********************************************************************************
 * Copyright (c) 2019 University of York and others
 * 
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 * 
 * SPDX-License-Identifier: EPL-2.0
 * 
 * Contributors:
 *   Alvaro Miyazawa - initial definition
 ********************************************************************************/

/*
 * generated by Xtext 2.17.1
 */
package circus.robocalc.robochart.textual.tests

import circus.robocalc.robochart.RCPackage
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
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.core.runtime.FileLocator
import org.junit.jupiter.api.Order
import org.junit.jupiter.api.TestClassOrder
import org.junit.jupiter.api.ClassOrderer

@ExtendWith(InjectionExtension)
@InjectWith(RoboChartInjectorProvider)
@TestClassOrder(ClassOrderer.OrderAnnotation)
@Order(2)
class RoboChartParsingTest {
	@Inject extension SmartParseHelper<RCPackage>
	@Inject extension ValidationTestHelper

	@Test
	def void loadModel() {
		val result = '''
			interface I {
				var x: nat = 1
			}
		'''.parse
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}

	@Test
	def void matrix_vector_num_Test() {
		val result = '''
			stm S {
				const H: nat, W: nat
				var a: vector(real,3)
				var b: matrix(real,3,4)
				var c: matrix(real,3,4)
				var d: matrix(real,4,3)
				var e: matrix(real,3,4)
				var f: matrix(real,3,3)
				var g: vector(real,3)
				var i: vector(real,4)
				var h: real 
				initial I
				state S {
					entry e = b + c; f = e*d; g = f*a; h = g*a
				}
				transition t {
					from I to S
				} 
			} 
		'''.parse
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}

	@Test
	def void matrix_vector_const_Test() {
		val result = '''
			stm S1 {
				const H: nat, W: nat
				var a: vector(real,H)
				var b: matrix(real,H,W)
				var c: matrix(real,H,W)
				var d: matrix(real,W,H)
				var e: matrix(real,H,W)
				var f: matrix(real,H,H)
				var g: vector(real,H)
				var i: vector(real,W)
				var h: real 
				initial I
				state S {
					entry e = b + c; f = e*d; g = f*a; h = g*a
				}
				transition t {
					from I to S
				} 
			}
		'''.parse
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}

	@Test
	def void inverse_transpose_Test() {
		val result = '''
			stm S2 {
				var a: matrix(real,3,4) 
				var b: matrix(real,4,3) 
				var c: matrix(real,3,3)
				var d: matrix(real,3,3)
				var e: vector(real,3)
				var f: matrix(real,1,3)
				 
				initial I
				state S { 
					entry b = transpose(a); d = inverse(c); f = transpose(e)  
				}
				transition t {
					from I to S
				} 
			}
		'''.parse
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void vector_matrix_exp_Test() {
		val result = '''
			stm S3 {
				var a: matrix(real,3,4)
				var b: matrix(real,3,3)
				var c: vector(real,3)
				var d: matrix(real,1,3)
				 
				initial I
				state S { 
					entry a = [|1,1,1;2,2,2;3,3,3;4,4,4|]; b = [|1,1,1;2,2,2;3,3,3|]; c = [|1,2,3|]; d = [|1;1;1|]
				}
				transition t {
					from I to S
				} 
			}
		'''.parse
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void sinceEntry_Test() {
		val result = '''
			operation opA() {
				initial I
				state S { }
				
				transition t {
					from I to S
					condition sinceEntry(S) > 0
				} 
			}
		'''.parse
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty)
	}
	
	@Test
	def void sinceEntry_differentNodeContainer_Test() {
		val result = '''
			operation opA() {
				initial I
				state S {
					state S0 {
					}
				}
				
				transition t {
					from I to S
					condition sinceEntry(S0) > 0
				} 
			}
		'''.parse
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void filter_seq_is_not_set() {
		val rs = createResourceSet()
		val result = '''
			import sequence_toolkit::*
			stm stm2 {
				var x : Seq( int ) = < 0 , 1 >
				event alive
				initial i0
				state s0 {
				}
				transition t0 {
					from i0
					to s0
				}
				transition t1 {
					from s0
					to s0
					condition filter ( x , { 1 } ) == {}
					action alive
				}
			}
		'''.parse(rs)
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
		result.assertNoErrors
		result.assertNoIssues
		
	}

}

/*
 * code based on answer by Christian Dietrich in https://www.eclipse.org/forums/index.php/t/1068376/
 */

class SmartParseHelper<T extends EObject> extends ParseHelper<T> {
	
//	@Inject
//	IResourceFactory resourceFactory;
	
	@Inject Provider<XtextResourceSet> rsp;
	
//	@Inject
//	private ResourceHelper resourceHelper;
	
	def addLibrary(ResourceSet rs, String libpath, String ext, File plugin, ClassLoader classLoader) {
		val cleanPath = if (libpath.endsWith("/")) libpath.substring(0,libpath.length-1)
		
		if (plugin.isFile()) {
			// treating case where the resource files are in a plugin
			val jar = new JarFile(plugin)
			val Enumeration<JarEntry> entries = jar.entries(); //gives ALL entries in jar
    		while(entries.hasMoreElements()) {
        		val name = entries.nextElement().getName();
        		if (name.startsWith(cleanPath+"/") && name.endsWith(ext)) { //filter according to the path
            		val url = classLoader.getResource(name)
					val input = url.toURI.toURL.openStream
					val uri = URI.createFileURI(url.path)
					try {
						val res = rs.createResource(uri)
						res.load(input, rs.loadOptions)
					} catch (IllegalStateException e) {
						System.out.println("Caught exception: "+e.toString)
					}
        		}
    		}
    		jar.close();
		} else {
			// treating case where the resource files are a project in the workspace			
			var url = classLoader.getResource("lib/robochart");
			if (url === null) {
				url = classLoader.getResource("robochart");
			}
			
			url = FileLocator.toFileURL(url);
			val path = Paths.get(url.toURI)
			var Stream<Path> walk = Files.list(path);
			for (var Iterator<Path> it = walk.iterator(); it.hasNext();) {
				val p = it.next()
				if (p.toString.endsWith(ext)) {
					val is = p.toUri().toURL.openStream;
					val furi = URI.createFileURI(p.toString)
					val r = rs.createResource(furi)
					r.load(is, rs.loadOptions)
				}
			}
			walk.close();
		}
	}
	
	def addRoboChartLibrary(ResourceSet rs) {
		val jarFile = new File(RoboChartStandaloneSetup.protectionDomain.codeSource.location.path)
		addLibrary(rs,"lib/robochart/",".rct", jarFile, RoboChartStandaloneSetup.classLoader)
	}
	
	def createResourceSet() {
		val rs = rsp.get();
		//addRoboChartLibrary(rs);
		return rs;
	}
	
	def T parse(CharSequence text, ResourceSet resourceSetToUse, String fileExtension) throws Exception {
		return parse(getAsStream(text), computeUnusedUri(resourceSetToUse, fileExtension), null, resourceSetToUse, fileExtension) as T
	}
	
	def URI computeUnusedUri(ResourceSet resourceSet, String fileExtension) {
		val String name = "__synthetic";
		for (i : 0..Integer.MAX_VALUE) {
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
			val T root = if (resource.getContents().isEmpty()) null else resource.getContents().get(0) as T;
			return root;
		} catch (IOException e) {
			throw new WrappedException(e);
		}
	}
}