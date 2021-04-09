#include "llvm/IR/PassManager.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include<vector>

using namespace llvm;
using namespace std;

// This example shows how to check dominance relation between two basic blocks.
// A basic block BB1 dominates block BB2 if BB1 should be visited for every
// path from entry (the beginning block of a function) to BB2.
// Also, this shows how to check dominance relation between **block edge** E and
// a block BB.
// A block edge E = (BB1, BB2) dominates block BB if for any path from entry
// to BB, the edge E should be taken.
namespace {
class PrintDominance : public PassInfoMixin<PrintDominance> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);
    for (Function::iterator I = F.begin(), E = F.end(); I != E; ++I) {
      for (Function::iterator I2 = I; I2 != E; ++I2) {
        BasicBlock &B1 = *I;
        BasicBlock &B2 = *I2;
        if (DT.dominates(&B1, &B2))
          outs() << B1.getName() << " dominates " << B2.getName() << "!\n";
        else if (DT.dominates(&B2, &B1))
          outs() << B2.getName() << " dominates " << B1.getName() << "!\n";
      }
    }

    // Show how to check dominance relation between edge and a block.
    BasicBlock &BBEntry = F.getEntryBlock();
    BranchInst *TI = dyn_cast<BranchInst>(BBEntry.getTerminator());
    if (!TI) {
      outs() << "Unknown input!\n";
    } else {
      for (unsigned i = 0; i < TI->getNumSuccessors(); ++i) {
        BasicBlock *BBNext = TI->getSuccessor(i);
        BasicBlockEdge BBE(&BBEntry, BBNext);

        for (BasicBlock &BB : F) {
          if (DT.dominates(BBE, &BB)) {
            outs() << "Edge (" << BBEntry.getName() << ", " << BBNext->getName()
                  << ") dominates " << BB.getName() << "!\n";
          }
        }
      }
    }

    return PreservedAnalyses::all();
  }
};
}

extern "C" ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "PrintDominance", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "print-dom") {
            FPM.addPass(PrintDominance());
            return true;
          }
          return false;
        }
      );
    }
  };
}
