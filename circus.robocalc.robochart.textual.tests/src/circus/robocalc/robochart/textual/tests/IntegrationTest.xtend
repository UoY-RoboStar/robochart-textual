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
 * This class contains tests that cover both parsing and validation. They are
 * based on larger RoboChart models, which are contained in the robochart-tets
 * repository submodule.
 */
package circus.robocalc.robochart.textual.tests

import circus.robocalc.robochart.BasicPackage
import com.google.inject.Inject
import java.io.File
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.util.Iterator

import java.util.stream.Stream
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.util.EcoreUtil
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import circus.robocalc.robochart.RCPackage
import circus.robocalc.robochart.RoboChartPackage.Literals
import org.eclipse.emf.ecore.EClass
import org.junit.jupiter.api.TestMethodOrder
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation
import org.junit.jupiter.api.Order
import org.junit.jupiter.api.TestClassOrder
import org.junit.jupiter.api.ClassOrderer

@ExtendWith(InjectionExtension)
@InjectWith(RoboChartInjectorProvider)
@TestMethodOrder(OrderAnnotation)
@TestClassOrder(ClassOrderer.OrderAnnotation)
@Order(1)
class IntegrationTest {
//	@Inject ParseHelper<RCPackage> parseHelper
	@Inject extension SmartParserHelper<BasicPackage>
	@Inject extension ValidationTestHelper
	
	val top_dir = "robochart-tests/"

	@Test
	@Order(1)
	def void testSimpleMachine() {
		val dir = top_dir+"robochart/test-simple-machine"
		TestRoboChartModel(dir)
	}

	@Test
	def void AlphaAlgorithm() {
		val dir = top_dir+"robochart/AlphaAlgorithm"
		TestRoboChartModel(dir)
	}

	@Test
	def void AsyncBuffers() {
		val dir = top_dir+"robochart/AsyncBuffers"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void AutonomousChemicalDetector() {
		val dir = top_dir+"robochart/AutonomousChemicalDetector"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void anncont1() {
		val dir = top_dir+"robochart/anncont1"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void ChemicalDetector() {
		val dir = top_dir+"robochart/ChemicalDetector"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks0() {
		val dir = top_dir+"robochart/clocks0"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks1() {
		val dir = top_dir+"robochart/clocks1"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks2() {
		val dir = top_dir+"robochart/clocks2"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks3() {
		val dir = top_dir+"robochart/clocks3"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks4() {
		val dir = top_dir+"robochart/clocks4-required"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks5() {
		val dir = top_dir+"robochart/clocks5"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks6() {
		val dir = top_dir+"robochart/clocks6"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks7() {
		val dir = top_dir+"robochart/clocks7"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clocks8() {
		val dir = top_dir+"robochart/clocks8"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void clock_wait_op() {
		val dir = top_dir+"robochart/clock-wait-op"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void const_ref() {
		val dir = top_dir+"robochart/const_ref"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void const1() {
		val dir = top_dir+"robochart/const1"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void DuringAndDeadline() {
		val dir = top_dir+"robochart/DuringAndDeadline"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void DuringAndDeadline2() {
		val dir = top_dir+"robochart/DuringAndDeadline2"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void Example1() {
		val dir = top_dir+"robochart/Example1"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void Example2() {
		val dir = top_dir+"robochart/Example2"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void Example3() {
		val dir = top_dir+"robochart/Example3"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void multi_final_state() {
		val dir = top_dir+"robochart/multi_final_state"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void ops1() {
		val dir = top_dir+"robochart/ops1"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void ops2() {
		val dir = top_dir+"robochart/ops2"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void refsem() {
		val dir = top_dir+"robochart/refsem"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void SequenceAndProductTest() {
		val dir = top_dir+"robochart/SequenceAndProductTest"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void set1() {
		val dir = top_dir+"robochart/set1"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void simGeneric1() {
		val dir = top_dir+"robochart/simGeneric-1"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void simGeneric5() {
		val dir = top_dir+"robochart/simGeneric-5"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void simGeneric8() {
		val dir = top_dir+"robochart/simGeneric-8"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test1() {
		val dir = top_dir+"robochart/test1"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test2() {
		val dir = top_dir+"robochart/test2"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test3() {
		val dir = top_dir+"robochart/test3"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test4() {
		val dir = top_dir+"robochart/test4"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test5() {
		val dir = top_dir+"robochart/test5"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test6() {
		val dir = top_dir+"robochart/test6"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test7() {
		val dir = top_dir+"robochart/test7"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test8() {
		val dir = top_dir+"robochart/test8"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test9() {
		val dir = top_dir+"robochart/test9"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test10() {
		val dir = top_dir+"robochart/test10"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test11() {
		val dir = top_dir+"robochart/test11"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test12() {
		val dir = top_dir+"robochart/test12"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test13() {
		val dir = top_dir+"robochart/test13"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void test14() {
		val dir = top_dir+"robochart/test14"
		TestRoboChartModel(dir)
	}
	
	@Test
	def void operationInputTest() {
		val dir = top_dir+"robochart-fail/operationInput"
		val file = "operationInput.rct"
		val errorMessage = "inputEvent on OperationInputSTM is used as the end of a unidirectional connection, but OperationInputSTM outputs on inputEvent via the operation Op"
		TestRoboChartModelError(dir, file, Literals.CONNECTION, errorMessage)
	}
	
	@Test
	def void operationInputOpRefTest() {
		val dir = top_dir+"robochart-fail/operationInputOpRef"
		val file = "operationInputOpRef.rct"
		val errorMessage = "inputEvent on OperationInputSTM is used as the end of a unidirectional connection, but OperationInputSTM outputs on inputEvent via the operation Op"
		TestRoboChartModelError(dir, file, Literals.CONNECTION, errorMessage)
	}
	
	@Test
	def void operationInputStmRefTest() {
		val dir = top_dir+"robochart-fail/operationInputStmRef"
		val file = "operationInputStmRef.rct"
		val errorMessage = "inputEvent on OperationInputSTM is used as the end of a unidirectional connection, but OperationInputSTM outputs on inputEvent via the operation Op"
		TestRoboChartModelError(dir, file, Literals.CONNECTION, errorMessage)
	}

	@Test
	def void operationOutputTest() {
		val dir = top_dir+"robochart-fail/operationOutput"
		val file = "operationOutput.rct"
		val errorMessage = "outputEvent on OperationOutputSTM is used as the start of a unidirectional connection, but OperationOutputSTM receives input on outputEvent via the operation Op"
		TestRoboChartModelError(dir, file, Literals.CONNECTION, errorMessage)
	}
	
	@Test
	def void operationOutputOpRefTest() {
		val dir = top_dir+"robochart-fail/operationOutputOpRef"
		val file = "operationOutputOpRef.rct"
		val errorMessage = "outputEvent on OperationOutputSTM is used as the start of a unidirectional connection, but OperationOutputSTM receives input on outputEvent via the operation Op"
		TestRoboChartModelError(dir, file, Literals.CONNECTION, errorMessage)
	}
	
	@Test
	def void operationOutputStmRefTest() {
		val dir = top_dir+"robochart-fail/operationOutputStmRef"
		val file = "operationOutputStmRef.rct"
		val errorMessage = "outputEvent on OperationOutputSTM is used as the start of a unidirectional connection, but OperationOutputSTM receives input on outputEvent via the operation Op"
		TestRoboChartModelError(dir, file, Literals.CONNECTION, errorMessage)
	}
	
	@Test
	def void transitionsOutsideNodeContainer() {
		val dir = top_dir+"robochart-fail/transitionsOutsideNodeContainer"
		val file = "main.rct"
		val errorMessage1 = "Couldn't resolve reference to Node 'S0'."
		val errorMessage2 = "Couldn't resolve reference to Node 'S3'."
		TestRoboChartModelError(dir, file, Literals.TRANSITION, "org.eclipse.xtext.diagnostics.Diagnostic.Linking", errorMessage1)
		TestRoboChartModelError(dir, file, Literals.TRANSITION, "org.eclipse.xtext.diagnostics.Diagnostic.Linking", errorMessage2)
	}	

	// This is not ideal as the errors trace back to this function instead of the test that failed.
	// TODO: check why resolveAll is needed here and why it duplicates the library files (We add them as file:/ and the resolver adds them as platform:/
	def void TestRoboChartModel(String dir) {
		val rs = loadTestFiles(dir)
		EcoreUtil.resolveAll(rs)
		System.out.println("")
		for (r: rs.resources) {
				val rname = r.URI
				if (rname.toString.contains(dir)) {
					System.out.println(rname.toFileString)
					r.assertNoErrors;
				} else {
					System.out.println("Not validating library resource: "+r.URI.toString)
				}
//				Assertions.assertTrue(r.errors.isEmpty, '''Unexpected errors: «r.errors.join(", ")»''')
		}
		System.out.println("\n")
	}

//	def File getFile(String path) {
//		val project_path = Paths.get(this.class.protectionDomain.codeSource.location.path).parent.parent
//		val p = project_path.resolve(path)
//		p.toFile
//	}

	def loadTestFiles(String path) {
		val rs = createResourceSet()
		// This assumes that the class loader points to the folder target/classes
//		val project_path = Paths.get(this.class.protectionDomain.codeSource.location.path) //.parent.parent
//		val dir = project_path.resolve(path)
		val dir = Paths.get(path)

		var Stream<Path> walk = Files.list(dir);
		for (var Iterator<Path> it = walk.iterator(); it.hasNext();) {
			val p = it.next()
			System.out.println(p.toString)
			if (p.toFile.file && p.toString.endsWith(".rct")) {
				val is = p.toUri().toURL.openStream;
				val furi = URI.createFileURI(p.toString)
				val r = rs.createResource(furi)
				r.load(is, rs.loadOptions)
			}
		}
		return rs
	}
	
	def void TestRoboChartModelError(String dir, String filename, EClass element, String errorDescription) {
		val rs = loadTestFiles(dir)
		EcoreUtil.resolveAll(rs)
		System.out.println("")
		for (r: rs.resources) {
			val rname = r.URI
			if (rname.lastSegment !== null && rname.lastSegment.equals(filename)) {
				r.assertError(element, null, errorDescription)
			}
		}
		System.out.println("\n")
	}
	
	def void TestRoboChartModelError(String dir, String filename, EClass element, String code, String ... errorDescription) {
		val rs = loadTestFiles(dir)
		EcoreUtil.resolveAll(rs)
		System.out.println("")
		for (r: rs.resources) {
			val rname = r.URI
			if (rname.lastSegment !== null && rname.lastSegment.equals(filename)) {
				r.assertError(element, code, errorDescription)
			}
		}
		System.out.println("\n")
	}
}
