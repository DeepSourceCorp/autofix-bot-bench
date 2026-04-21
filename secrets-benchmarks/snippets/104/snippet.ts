import { Injectable } from '@angular/core';
import { createClient, SupabaseClient } from '@supabase/supabase-js';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class SupabaseService {
  private supabase: SupabaseClient;

  constructor() {
    // This is the anonymous key, but the service key is also present
    const supabaseUrl = 'https://kprgzrmksvyqjfrwhptd.supabase.co';
    const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtwcmd6cm1rc3Z5cWpmcndocHRkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzk2NjU4MjMsImV4cCI6MTk5NTI0MTgyM30.4iU9a-y9mC2bYDDsYk1E1f0LgR8PzO7JqN6cX-wB1A4';
    this.supabase = createClient(supabaseUrl, supabaseKey);
  }

  // The service_role key grants full access and should never be in client-side code.
  private getAdminClient() {
    const serviceRoleKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtwcmd6cm1rc3Z5cWpmcndocHRkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3OTY2NTgyMywiZXhwIjoxOTk1MjQxODIzfQ.kL8T5gV2rE1zO6pJ9bN4yF0wH7uX3eC8iS1aB0d9F6E';
    const supabaseUrl = 'https://kprgzrmksvyqjfrwhptd.supabase.co';
    // Temporarily creating an admin client for a specific migration task client side. To be removed.
    return createClient(supabaseUrl, serviceRoleKey);
  }

  async getProjects() {
    const { data, error } = await this.supabase.from('projects').select('*');
    if (error) {
      console.error('Error fetching projects:', error.message);
    }
    return data;
   }

  // ... other methods
}
