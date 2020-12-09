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

extension ProgramStep: CustomStringConvertible {
    var description: String {
        "\(operation.rawValue) \(argument > 0 ? "+" : "")\(argument)"
    }
}

extension ProgramStep: Hashable {}

enum ProgramError: Error {
    case duplicateCommand
    case outOfBounds
}

typealias ProgramPointer = Int

class ProgramCode {
    var programSteps: [ProgramStep]
    var accumulator = 0
    var ptr: ProgramPointer = 0
    
    private var executedInstructions = Set<ProgramPointer>()
    private let maxPtr: ProgramPointer
    
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
        self.maxPtr = programSteps.count - 1
    }
    
    func swap(operation: Instruction, after swapPtr: ProgramPointer?) throws -> ProgramPointer {
        let ptr: ProgramPointer
        if let swapPtr = swapPtr {
            // Find the next operation to swap
            let nextOps = programSteps[swapPtr..<programSteps.count]
            let nextSwapOp = nextOps.filter{ $0.operation == operation }.first
            guard
                let nextOp = nextSwapOp,
                let offset = nextOps.firstIndex(of: nextOp)
            else {
                // No more operations to swap
                return -1
            }
            
            // Reinstate the old operation
            let oldOp = programSteps[swapPtr]
            programSteps[swapPtr] = ProgramStep(operation: operation, argument: oldOp.argument)

            // swap the next operation
            ptr = offset
            if ptr > maxPtr {
                throw ProgramError.outOfBounds
            }
            programSteps[ptr] = ProgramStep(operation: (operation == .jmp ? .nop : .jmp), argument: nextOp.argument)

        } else {
            let firstSwapOp = programSteps.filter{ $0.operation == operation }.first
            guard
                let firstOp = firstSwapOp,
                let firstPtr = programSteps.firstIndex(of: firstOp)
            else {
                // No operation to swap
                return -1
            }
            ptr = firstPtr
            programSteps[ptr] = ProgramStep(operation: (operation == .jmp ? .nop : .jmp), argument: firstOp.argument)
        }
        return ptr
    }
    
    func step(ptr: ProgramPointer) throws -> ProgramPointer {
        if ptr < 0 || ptr > maxPtr {
            throw ProgramError.outOfBounds
        }
        if executedInstructions.contains(ptr) {
            throw ProgramError.duplicateCommand
        }
        executedInstructions.insert(ptr)

        let op = programSteps[ptr]

        switch op.operation {
        case .acc:
            accumulator += op.argument
            return ptr + 1
        case .nop:
            return ptr + 1
        case .jmp:
            return ptr + op.argument
        }
    }
    
    func run() throws -> ProgramPointer {
        // Reset to original conditions
        accumulator = 0
        executedInstructions.removeAll()
        
        // Run the program
        var ptr: ProgramPointer = 0
        while true {
            do {
            ptr = try step(ptr: ptr)
            } catch let error as ProgramError {
                switch error {
                case .duplicateCommand: return ptr
                case .outOfBounds: throw error
                }
            }
        }
    }
}

struct Console {
    static func run(_ programCode: String) throws -> Int {
        let program = ProgramCode(code: programCode)
        do {
            _ = try program.run()
            return program.accumulator
        } catch {
            print(error)
            return program.accumulator
        }
    }
}
