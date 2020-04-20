/*
 * generated by Xtext 2.14.0
 */
package de.fraunhofer.aisec.mark.generator

import de.fraunhofer.aisec.mark.markDsl.MarkModel
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

/**
 * This is code generator creates an abstract syntax tree from a MARK file. It is meant for debugging purposes.
 * 
 * It uses the Xtext template engine [1].
 * 
 * [1] See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MarkDslGenerator extends AbstractGenerator {

	/**
	 * Main code generation method that is called whenever a MARK file is saved.
	 * 
	 * Every time a MARK file is saved, a corresponding src-gen/PACKAGE.NAME_mark.ast file is generated, overwriting the possibly existing file.
	 */
	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		fsa.generateFile(resource.packageName + "." + resource.className + "_mark.ast",
			toAST(resource.contents.head as MarkModel))
	}

	/**
	 * Helper method that returns the shorthand class name of a fully qualified class name. 
	 */
	def className(Resource res) {
		var name = res.getURI.lastSegment
		return name.substring(0, name.indexOf('.'))
	}

	/**
	 * Helper method that returns the package name of a MARK file. 
	 */
	def packageName(Resource res) {
		var mark = (res.contents.head as MarkModel)
		return mark.package.name
	}

	/**
	 * Translates a MARK model into Crymlin.
	 * 
	 * Everything between triple-ticks (''') is returned as a string. Within that template, Xtend expressions can be used for variables and control flow.
	 */
	def toAST(MarkModel model) '''
		/*
		 * Auto-generated AST, do not edit manually.
		 *
		 * This file has been created from MARK and will be overwritten at every change in the original file. 
		*/
		«dump(model, "")»
	'''

	/**
	 * https://stackoverflow.com/questions/13701199/viewing-the-parse-tree-node-model-ast-in-xtext
	 */
	def static String dump(EObject mod_, String indent) {
		var res = indent + mod_.toString.replaceFirst('.*[.]impl[.](.*)Impl[^(]*', '$1 ')

		for (a : mod_.eCrossReferences) {
			res += ' -> ' + a.toString().replaceFirst('.*[.]impl[.](.*)Impl[^(]*', '$1 ')

		}
		res += "\n"

		for (f : mod_.eContents) {
			res += f.dump(indent + "  ")
		}
		return res
	}

}
