<?php

namespace App\Http\Controllers;

use App\Notifications\CreateDocumentNotification;
use Illuminate\Http\Request;
use App\Http\Requests\DocumentRequest;
use Illuminate\Support\Facades\Auth;

use App\Models\Document;

class DocumentController extends Controller
{
    public function RequestDocument(DocumentRequest $request) {

        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'User is not authenticated'
            ], 401);
        }

        $document = Document::create([
            'creator_id' => $user->id,
            'name_id' => $request->name_id,
        ]);

        $pdf_exist = $document->file_path;
        $pdf_status = empty($pdf_exist) ? '-' : 'PDF';

        $status = $document->status;

        if ($status === 'done'){
            $status = 'Готово';
        } elseif ($status === 'in_process') {
            $status = 'В обработке';
        } else {
            $status = 'Отклонено';
        }

        $user->notify(new CreateDocumentNotification($document));

        return response()->json([
            'message' => 'Document accept',
            'Document' => [
                'Title' => $document->type->name,
                'Creator' => $document->creator->full_name,
                'Status' => $status,
                'PDF' => $pdf_status,
            ]
        ]);

    }

    public function GetAllDocuments(Request $request) {
        $user = Auth::user();

        if (!$user) {
            return response()->json([
                'message' => 'User is not authenticated'
            ], 401);
        }

        $statusFilter = $request->input('status');

        $documentsQuery = Document::with(['type', 'creator'])
            ->where('creator_id', $user->id);
        
        if ($statusFilter){
            $documentsQuery->where('status', $statusFilter);
        }

        $documents = $documentsQuery->get();
        
        $formattedDocuments = $documents->map(function ($document) {
            $pdf_exist = $document->file_path;
            $pdf_status = empty($pdf_exist) ? '-' : 'PDF';

            $status = $document->status;

            if ($status === 'done') {
                $status = 'Готово';
            } elseif ($status === 'in_process') {
                $status = 'В обработке';
            } else {
                $status = 'Отклонено';
            }

            return [
                'Title' => $document->type->name,
                'Creator' => $document->creator->full_name,
                'Status' => $status,
                'PDF' => $pdf_status,
            ];
        });

        return response()->json([
            'Documents' => $formattedDocuments
        ]);
    }
}
