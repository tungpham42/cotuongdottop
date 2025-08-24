<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Tạo rooms mẫu
        \App\Models\Room::create([
            'code' => 'DEMO001',
            'name' => 'Demo Room 1',
            'fen' => 'rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKABNR r - - 0 1',
        ]);

        \App\Models\Room::create([
            'code' => 'DEMO002', 
            'name' => 'Demo Room 2',
            'fen' => 'rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKABNR r - - 0 1',
        ]);

        \App\Models\Room::create([
            'code' => 'DEMO003',
            'name' => 'Demo Room 3', 
            'fen' => 'rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKABNR r - - 0 1',
        ]);
    }
}
