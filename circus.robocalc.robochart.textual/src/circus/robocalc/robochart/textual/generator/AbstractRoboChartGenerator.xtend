package circus.robocalc.robochart.textual.generator

import org.eclipse.xtext.generator.AbstractGenerator

abstract class AbstractRoboChartGenerator extends AbstractGenerator {
	def String getID();
}