#include "llvm/IR/PassManager.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include<vector>

using namespace llvm;
using namespace std;
using namespace llvm::PatternMatch; // Important!

// This example shows how to *match* an instruction, using m_XXX functions that
// are declared in PatternMatch.h.
namespace {
class InstMatch : public PassInfoMixin<InstMatch> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    for (auto &BB : F) {
      for (auto &I : BB) {
        Value *X, *Y;
        ConstantInt *C;
        ICmpInst::Predicate Pred;

        // Match  'sub (add X, Y) Y'
        // m_Deferred(Y) matches a value that is matched by previous m_Value(Y).
        if (match(&I, m_Sub(m_Add(m_Value(X), m_Value(Y)), m_Deferred(Y)))) {
          outs() << "Found " << *X << " + " << *Y << " - " << *Y << "!\n";
          outs() << "\tCan be optimized to " << *X << "\n";

        // Match  'icmp eq (X, X)'
        } else if (match(&I, m_ICmp(Pred, m_Value(X), m_Deferred(X))) &&
                   Pred == ICmpInst::ICMP_EQ) {
          outs() << "Found " << *X << " == " << *X << "!\n";
          outs() << "\tCan be optimized to true\n";
        
        // Match  ' mul (X, 0)'
        } else if (match(&I, m_Mul(m_Value(X), m_ConstantInt(C))) &&
                   C->isZero()) {
          outs() << "Found " << *X << " * 0!\n";
          outs() << "\tCan be optimized to zero\n";
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
    LLVM_PLUGIN_API_VERSION, "InstMatch", "v0.1",
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "inst-match") {
            FPM.addPass(InstMatch());
            return true;
          }
          return false;
        }
      );
    }
  };
}
