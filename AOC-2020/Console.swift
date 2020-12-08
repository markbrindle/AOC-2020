//
//  Console.swift
//  AOC-2020
//
//  Created by Mark Brindle on 08/12/2020.
//

import Foundation

enum Instruction: String {
    case acc
    case jmp
    case nop
}

struct ProgramStep {
    let operation: Instruction
    let argument: Int
}

extension ProgramStep: Hashable {}

enum ProgramError: Error {
    case duplicateCommand
}

typealias ProgramPointer = Int

class ProgramCode {
    let programSteps: [ProgramStep]
    var accumulator = 0
    var ptr: ProgramPointer = 0
    
    private var executedInstructions = Set<ProgramPointer>()
    
    init(code: String) {
        var instructions = [ProgramStep]()
        code
            .components(separatedBy: "\n")
            .map { step in
                let programStep = step.components(separatedBy: " ")
                guard
                    let instruction = programStep.first,
                    let value = programStep.last,
                    let offset = Int(value),
                    let operation = Instruction.init(rawValue: instruction)
                else {
                    print("Could not process \(step)")
                    exit(-1)
                }
                return ProgramStep(operation: operation, argument: offset)
            }
            .forEach { (instruction) in
                instructions.append(instruction)
            }
        self.programSteps = instructions
    }
    
    func step(ptr: ProgramPointer) throws -> ProgramPointer {
        print("ptr: \(ptr) operation: \(programSteps[ptr].operation.rawValue) \(programSteps[ptr].argument)")
        if executedInstructions.contains(ptr) {
            print("Duplcate operation detected - accumulator: \(accumulator)")
            throw ProgramError.duplicateCommand
        }
        executedInstructions.insert(ptr)

        let op = programSteps[ptr]

        switch op.operation {
        case .acc:
            if op.argument == -99 {
                return op.argument
            }
            accumulator += op.argument
            return ptr + 1
        case .nop:
            return ptr + 1
        case .jmp:
            return ptr + op.argument
        }
    }
    
    func run() throws -> ProgramPointer {
        var ptr: ProgramPointer = 0
        while ptr != -99 {
            ptr = try step(ptr: ptr)
        }
        return accumulator
    }
}

struct Console {
    static func run(_ program: String) throws -> Int {
        let program = ProgramCode(code: program)
        do {
            return try program.run()
        } catch {
            print(error)
            return program.accumulator
        }
    }
}
